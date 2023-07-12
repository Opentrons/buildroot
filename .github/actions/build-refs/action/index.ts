import { getOctokit } from '@actions/github'
import * as core from '@actions/core'

export type Repo = 'buildroot' | 'monorepo'
export type BuildType = 'develop' | 'release'

const orderedRepos: Repo[] = ['monorepo', 'buildroot']

export type Branch = string
export type Tag = string
export type Ref = Branch | Tag

export type InputRefs = Map<Repo, Ref | null>

export type AttemptableTag = Tag | ':latest:'
export type AttemptableRef = AttemptableTag | Branch

export type AttemptableRefs = Map<Repo, AttemptableRef[]>

export type OutputRefs = Map<Repo, Ref>

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

function latestTagPrefixFor(repo: Repo): string {
  if (repo === 'monorepo') return 'refs/tags/v'
  if (repo === 'buildroot') return 'refs/tags/v'
  throw new Error(`Unknown repo ${repo}`)
}

export function latestTag(tagRefs: GitHubApiTag[]): Tag | null {
  return (tagRefs.at(-1)?.ref as Tag | null | undefined) ?? null
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

export function authoritativeRef(inputs: InputRefs): [Ref, boolean] {
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

function getInputs(): InputRefs {
  return orderedRepos.reduce((prev: InputRefs, inputName: Repo): InputRefs => {
    const input = core.getInput(inputName)
    return prev.set(inputName, input == '-' ? null : input)
  }, new Map())
}

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

async function resolveRefs(toAttempt: AttemptableRefs): Promise<OutputRefs> {
  const token = core.getInput('token')
  let resolved = new Map()
  for (const [repo, refList] of toAttempt) {
    const octokit = getOctokit(token)

    const fetchTags = async (repoName: Repo): Promise<Ref | null> => {
      core.info(`finding latest tag for ${repoName}`)
      return octokit.rest.git
        .listMatchingRefs({
          ...restDetailsFor(repoName),
          ref: restAPICompliantRef(latestTagPrefixFor(repoName)),
        })
        .then(response => {
          if (response.status != 200) {
            throw new Error(
              `Bad response from github api for ${repoName} get tags: ${response.status}`
            )
          }
          return latestTag(response.data)
        })
    }

    // this is a big function to be inline and untestable, but tookit doesn't export
    // the type for the octokit object above so what are you gonna do
    const refResolves = async (
      repoName: Repo,
      ref: AttemptableRef
    ): Promise<Ref | null> => {
      core.info(`looking for ${ref} on ${repoName}`)
      const correctRef = ref === ':latest:' ? await fetchTags(repoName) : ref
      if (correctRef === null) {
        core.info(`couldn't find ref ${correctRef} for ${ref} on ${repoName}`)
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
          core.info(`refs on ${repoName} matching ${ref}: ${availableRefs}`)
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

export function resolveBuildType(ref: Ref): BuildType {
  return ref.includes('refs/tags/ot3') ? 'release' : 'develop'
}

async function run() {
  const inputs = getInputs()
  inputs.forEach((ref, repo) => {
    core.debug(`found input for ${repo}: ${ref}`)
  })
  const [authoritative, isMain] = authoritativeRef(inputs)
  core.debug(`authoritative ref is ${authoritative} (main: ${isMain})`)
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
    core.debug(`found attemptable refs for ${repo}: ${refs.join(', ')}`)
  })

  const resolved = await resolveRefs(attemptable)
  resolved.forEach((ref, repo) => {
    core.info(`Resolved ${repo} to ${ref}`)
    core.setOutput(repo, ref)

    // Determine the build-type based on the monorepo ref
    if (repo === 'monorepo') {
      const buildType = resolveBuildType(ref)
      core.info(`Resolved buildroot build-type to ${buildType}`)
      core.setOutput('build-type', buildType)
    }
  })
}

async function _run() {
  try {
    await run()
  } catch (error: any) {
    core.setFailed(error.toString())
  }
}

_run()
