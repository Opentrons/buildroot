import * as action from '../index'
import type { InputRefs, Ref, Branch, BuildType, Channel } from '../index'

const AUTHORITATIVE_REF_TEST_SPECS: Array<
  [string, InputRefs, [string, boolean]]
> = [
  [
    'prefers monorepo if buildroot not specified',
    new Map([
      ['buildroot', null],
      ['monorepo', 'refs/heads/edge'],
    ]),
    ['refs/heads/edge', true],
  ],
  [
    'uses buildroot if monorepo not specified',
    new Map([
      ['buildroot', 'refs/heads/opentrons-develop'],
      ['monorepo', null],
    ]),
    ['refs/heads/opentrons-develop', true],
  ],
  [
    'prefers monorepo if both specified',
    new Map([
      ['buildroot', 'refs/heads/opentrons-develop'],
      ['monorepo', 'refs/heads/edge'],
    ]),
    ['refs/heads/edge', true],
  ],
  [
    'identifies if monorepo preferred but on non-main branch',
    new Map([
      ['buildroot', 'refs/heads/opentrons-develop'],
      ['monorepo', 'refs/heads/some-test-branch'],
    ]),
    ['refs/heads/some-test-branch', false],
  ],
  [
    'identifies if buildroot preferred but on non-main branch',
    new Map([
      ['buildroot', 'refs/heads/some-test-branch'],
      ['monorepo', null],
    ]),
    ['refs/heads/some-test-branch', false],
  ],
  [
    'falls back to main branches if nothing is specified',
    new Map([
      ['buildroot', null],
      ['monorepo', null],
    ]),
    ['refs/heads/edge', true],
  ],
]

AUTHORITATIVE_REF_TEST_SPECS.forEach(
  ([testNameFragment, inputRefs, result]) => {
    test(`authoritativeRef ${testNameFragment}`, () => {
      expect(action.authoritativeRef(inputRefs)).toStrictEqual(result)
    })
  }
)

const REFS_TO_ATTEMPT_TEST_SPECS: Array<
  [string, [Ref, boolean, Branch], Ref[]]
> = [
  [
    'with non-main branches should prioritize the request and then use main',
    ['refs/heads/someBranch', false, 'refs/heads/someMain'],
    ['refs/heads/someBranch', 'refs/heads/someMain'],
  ],
  [
    'with main branches should just use main',
    ['refs/heads/someOtherMain', true, 'refs/heads/someMain'],
    ['refs/heads/someMain'],
  ],
  [
    'with tags should prioritize match tag, then latest',
    ['refs/tags/someTag', false, 'refs/heads/someMain'],
    ['refs/tags/someTag', ':latest:', 'refs/heads/someMain'],
  ],
]

REFS_TO_ATTEMPT_TEST_SPECS.forEach(
  ([
    testNameFragment,
    [testRequesterRef, testRequesterIsMain, testRequestedMain],
    testResults,
  ]) => {
    test(`refsToAttempt ${testNameFragment}`, () => {
      expect(
        action.refsToAttempt(
          testRequesterRef,
          testRequesterIsMain,
          testRequestedMain
        )
      ).toStrictEqual(testResults)
    })
  }
)

const REFS_TO_ATTEMPT_FAILURE_TEST_SPECS: Array<
  [string, [Ref, boolean, Branch]]
> = [
  [
    'when called with a short refname throws',
    ['shortBranchName', true, 'refs/heads/someMain'],
  ],
]

REFS_TO_ATTEMPT_FAILURE_TEST_SPECS.forEach(
  ([
    testNameFragment,
    [testRequesterRef, testRequesterIsMain, testRequestedMain],
  ]) => {
    test(`refsToAttempt ${testNameFragment}`, () => {
      expect(() => {
        action.refsToAttempt(
          testRequesterRef,
          testRequesterIsMain,
          testRequestedMain
        )
      }).toThrow()
    })
  }
)

const BUILD_TYPE_TEST_SPECS: Array<[string, [Ref], BuildType, Channel]> = [
  [
    'when monorepo ref is edge but is not a tag is develop on i-r',
    ['refs/heads/edge'],
    'develop',
    'internal-release',
  ],
  [
    'when monorepo ref is some branch but is not a tag is develop on i-r',
    ['refs/heads/something'],
    'develop',
    'internal-release',
  ],
  [
    'when monorepo ref is a ot3-prefix tag is release on i-r',
    ['refs/tags/ot3@0.0.0-dev'],
    'release',
    'internal-release',
  ],
  [
    'when monorepo ref is a v-tag is develop on i-r',
    ['refs/tags/v0.0.0-dev'],
    'develop',
    'internal-release',
  ],
  [
    'when monorepo ref is edge but is not a tag is develop on f-r',
    ['refs/heads/edge'],
    'develop',
    'full-release',
  ],
  [
    'when monorepo ref is some branch but is not a tag is develop on f-r',
    ['refs/heads/something'],
    'develop',
    'full-release',
  ],
  [
    'when monorepo ref is a v-prefix tag is release on f-r',
    ['refs/tags/v0.0.0-dev'],
    'release',
    'full-release',
  ],
  [
    'when monorepo ref is ot3-tag is develop on f-r',
    ['refs/tags/ot3@0.0.0-dev'],
    'develop',
    'full-release',
  ],
]

BUILD_TYPE_TEST_SPECS.forEach(
  ([testNameFragment, [testMonorepoRef], testExpectedResult, testChannel]) => {
    test(`buildType ${testNameFragment}`, () => {
      expect(
        action.resolveBuildType(testMonorepoRef, testChannel)
      ).toStrictEqual(testExpectedResult)
    })
  }
)
