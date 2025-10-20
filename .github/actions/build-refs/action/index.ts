import { getOctokit } from '@actions/github'
import * as fs from 'fs'
import * as os from 'os'
import * as semver from 'semver'

// Custom implementations to avoid importing @actions/core which contains deprecated set-output
function getInput(name: string): string {
  return process.env[`INPUT_${name.replace(/ /g, '_').toUpperCase()}`] || ''
}

function info(message: string): void {
  console.log(message)
}

function debug(message: string): void {
  if (process.env['RUNNER_DEBUG'] === '1') {
    console.log(message)
  }
}

function setFailed(message: string): void {
  console.error(message)
  process.exit(1)
}

// Custom setOutput function that only uses GITHUB_OUTPUT (no deprecated set-output fallback)
function customSetOutput(name: string, value: string): void {
  const filePath = process.env['GITHUB_OUTPUT']
  if (!filePath) {
    throw new Error('GITHUB_OUTPUT environment variable is not set')
  }
  
  const delimiter = `_GitHubActionsFileCommandDelimiter_${Math.random().toString(36).substring(7)}_`
  const commandValue = `${name}<<${delimiter}${os.EOL}${value}${os.EOL}${delimiter}`
  fs.appendFileSync(filePath, commandValue + os.EOL)
}

export type Repo = 'buildroot' | 'monorepo'
export type BuildType = 'develop' | 'release'
export type Variant = 'release' | 'internal-release'

const orderedRepos: Repo[] = ['monorepo', 'buildroot']

export type Branch = string
export type Tag = string
export type Ref = Branch | Tag

export type Inputs = Map<Repo, Ref | null>

export type AttemptableTag = Tag | ':latest:'
export type AttemptableRef = AttemptableTag | Branch

export type AttemptableRefs = Map<Repo, AttemptableRef[]>

export type OutputRefs = Map<Repo, Ref>

export function variantForRef(ref: Ref): Variant {
  if (ref.startsWith('refs/heads')) {
    if (ref.includes('internal-release')) {
      return 'internal-release'
    } else {
      return 'release'
    }
  } else if (ref.startsWith('refs/tags')) {
    if (ref.includes('ot3@')) {
      return 'internal-release'
    } else if (ref.startsWith('refs/tags/v')) {
      return 'release'
    }
  }
  return 'internal-release'
}

function mainRefFor(input: Repo): Branch {
  return {
    monorepo: 'refs/heads/edge',
    buildroot: 'refs/heads/opentrons-develop',
  }[input]
}

export function restAPICompliantRef(input: Ref): string {
  return input.replace('refs/', '')
}

export interface GitHubApiTag {
  ref: Tag
}

function latestTagPrefixFor(repo: Repo, variant: Variant): string[] {
  if (variant === 'release') {
    return ['refs/tags/v']
  }
  if (variant === 'internal-release') {
    if (repo === 'monorepo') {
      return ['refs/tags/internal@', 'refs/tags/ot3@']
    }
    return ['refs/tags/internal@']
  }
  throw new Error(`Unknown variant ${variant}`)
}

export function latestTag(tagRefs: GitHubApiTag[]): Tag | null {
  if (tagRefs.length === 0) return null
  
  // Extract and parse version numbers from tag refs
  const tagVersions = tagRefs
    .map(tag => {
      const tagName = tag.ref.replace('refs/tags/', '')
      
      // Handle v* tags (e.g., "v1.19.4")
      if (tagName.startsWith('v')) {
        const version = tagName.substring(1)
        return { tag: tag.ref, version, isValid: semver.valid(version) }
      }
      
      // Handle internal@* tags (e.g., "internal@1.2.0-alpha.0")
      if (tagName.startsWith('internal@')) {
        const version = tagName.substring(9) // Remove "internal@"
        return { tag: tag.ref, version, isValid: semver.valid(version) }
      }
      
      // Handle ot3@* tags (e.g., "ot3@1.2.0-alpha.0")
      if (tagName.startsWith('ot3@')) {
        const version = tagName.substring(4) // Remove "ot3@"
        return { tag: tag.ref, version, isValid: semver.valid(version) }
      }
      
      // Unknown tag format
      return { tag: tag.ref, version: null, isValid: false }
    })
    .filter(tv => tv.isValid) // Only keep valid semantic versions
  
  if (tagVersions.length === 0) return null
  
  // Sort by semantic version and return the latest
  tagVersions.sort((a, b) => semver.compare(a.version!, b.version!))
  return tagVersions[tagVersions.length - 1].tag
}

function restDetailsFor(input: Repo): { owner: string; repo: string } {
  return {
    monorepo: { owner: 'Opentrons', repo: 'opentrons' },
    buildroot: { owner: 'Opentrons', repo: 'buildroot' },
  }[input]
}

function refIsMain(input: Ref, repo: Repo): boolean {
  return mainRefFor(repo) === input
}

export function authoritativeRef(inputs: Inputs): [Ref, boolean] {
  return (
    orderedRepos
      .map((repoName): [Ref, boolean] | null => {
        const inputRefForRepo = inputs.get(repoName)
        return inputRefForRepo
          ? [inputRefForRepo, refIsMain(inputRefForRepo, repoName)]
          : null
      })
      .find(el => el !== null) ?? ['refs/heads/edge', true]
  )
}

const getInputs = () =>
  orderedRepos.reduce((prev: Inputs, inputName: Repo): Inputs => {
    const input = getInput(inputName)
    return prev.set(inputName, input == '-' ? null : input)
  }, new Map())

function visitRefsByType<T>(
  ref: Ref,
  ifBranch: (branch: Branch) => T,
  ifTag: (tag: Tag) => T
): T {
  if (ref.startsWith('refs/heads')) return ifBranch(ref as Branch)
  if (ref.startsWith('refs/tags')) return ifTag(ref as Tag)
  throw new Error(
    `Ref ${ref} can't be matched to branch or tag, is it a shortref?`
  )
}

function branchesToAttempt(
  requesterBranch: Branch,
  requesterIsMain: boolean,
  requestedMain: Branch
): Ref[] {
  // if this is a main-branch build, use our main branch
  if (requesterIsMain) {
    return [requestedMain]
  }
  // otherwise, use a matching branchname and then our main branch
  return [requesterBranch, requestedMain]
}

function tagsToAttempt(
  requesterTag: Tag,
  requestedMain: Branch
): AttemptableTag[] {
  return [requesterTag, ':latest:', requestedMain]
}

export function refsToAttempt(
  requesterRef: Ref,
  requesterIsMain: boolean,
  requestedMain: Branch
): Ref[] {
  ///Based on the refs from whatever was specified, return an ordered list of refs to
  // try.
  return visitRefsByType(
    requesterRef,
    requesterBranch =>
      branchesToAttempt(requesterBranch, requesterIsMain, requestedMain),
    requesterTag => tagsToAttempt(requesterTag, requestedMain)
  )
}

async function resolveRefs(
  toAttempt: AttemptableRefs,
  variant: Variant
): Promise<OutputRefs> {
  const token = getInput('token')
  let resolved = new Map()
  for (const [repo, refList] of toAttempt) {
    const octokit = getOctokit(token)

    const fetchTags = async (repoName: Repo): Promise<Ref | null> => {
      info(`finding latest tag for ${repoName}`)
      return Promise.all(
        latestTagPrefixFor(repoName, variant).map(prefix =>
          octokit.rest.git
            .listMatchingRefs({
              ...restDetailsFor(repoName),
              ref: restAPICompliantRef(prefix),
            })
            .then(response => {
              if (response.status != 200) {
                throw new Error(
                  `Bad response from github api for ${repoName} get tags: ${response.status}`
                )
              }
              return latestTag(response.data)
            })
        )
      ).then(results =>
        results.reduce((prev, current) => prev ?? current, null)
      )
    }

    // this is a big function to be inline and untestable, but tookit doesn't export
    // the type for the octokit object above so what are you gonna do
    const refResolves = async (
      repoName: Repo,
      ref: AttemptableRef
    ): Promise<Ref | null> => {
      info(`looking for ${ref} on ${repoName}`)
      const correctRef = ref === ':latest:' ? await fetchTags(repoName) : ref
      if (correctRef === null) {
        info(`couldn't find ref ${correctRef} for ${ref} on ${repoName}`)
        return null
      }

      return octokit.rest.git
        .listMatchingRefs({
          ...restDetailsFor(repoName),
          ref: restAPICompliantRef(correctRef),
        })
        .then(value => {
          if (value.status != 200 || !value.data) {
            throw new Error(
              `Bad response from github api for ${repoName} get matching refs: ${value.status}`
            )
          }
          const availableRefs = value.data.map(refObj => refObj.ref)
          info(`refs on ${repoName} matching ${ref}: ${availableRefs}`)
          return availableRefs.includes(correctRef) ? correctRef : null
        })
    }

    resolved.set(
      repo,
      await Promise.all(refList.map(ref => refResolves(repo, ref))).then(
        presentRefs => presentRefs.find(maybeRef => maybeRef !== null)
      )
    )
  }
  return resolved
}

function resolveBuildTypeInternal(ref: Ref): BuildType {
  return ref.includes('refs/tags/ot3@') ? 'release' : 'develop'
}

function resolveBuildTypeExternal(ref: Ref): BuildType {
  return ref.includes('refs/tags/v') ? 'release' : 'develop'
}

export function resolveBuildType(ref: Ref, variant: Variant): BuildType {
  return variant === 'internal-release'
    ? resolveBuildTypeInternal(ref)
    : resolveBuildTypeExternal(ref)
}

async function run() {
  const inputs = getInputs()
  inputs.forEach((ref, repo) => {
    debug(`found input for ${repo}: ${ref}`)
  })
  const [authoritative, isMain] = authoritativeRef(inputs)
  debug(`authoritative ref is ${authoritative} (main: ${isMain})`)
  const variant = variantForRef(authoritative)
  const buildType = resolveBuildType(authoritative, variant)
  info(`Resolved build variant to ${variant}`)
  info(`Resolved buildroot build-type to ${buildType}`)
  customSetOutput('build-type', buildType)
  customSetOutput('variant', variant)

  const attemptable = Array.from(inputs.entries()).reduce(
    (prev: AttemptableRefs, [repoName, inputRef]): AttemptableRefs => {
      return prev.set(
        repoName,
        inputRef
          ? [inputRef]
          : refsToAttempt(authoritative, isMain, mainRefFor(repoName))
      )
    },
    new Map()
  )
  attemptable.forEach((refs, repo) => {
    debug(`found attemptable refs for ${repo}: ${refs.join(', ')}`)
  })

  const resolved = await resolveRefs(attemptable, variant)
  resolved.forEach((ref, repo) => {
    info(`Resolved ${repo} to ${ref}`)
    customSetOutput(repo, ref)
  })
}

async function _run() {
  try {
    await run()
  } catch (error: any) {
    setFailed(error.toString())
  }
}

_run()
