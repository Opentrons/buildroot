'use strict'

module.exports = {
  root: true,

  parserOptions: {
    project: './tsconfig-eslint.json',
  },

  extends: ['standard-with-typescript', 'prettier'],

  plugins: ['json', 'jest'],

  rules: {
    camelcase: 'off',
    'no-var': 'error',
    'prefer-const': 'error',
    'no-extra-boolean-cast': 'off',
    'import/no-default-export': 'error',
    '@typescript-eslint/promise-function-async': 'off',
    '@typescript-eslint/default-param-last': 'off',
  },

  globals: {},

  env: {
    node: true,
    browser: false,
  },

  overrides: [
    {
      files: [
        '**/test/**.js',
        '**/__tests__/**.@(js|ts|tsx)',
        '**/__mocks__/**.@(js|ts|tsx)',
        '**/__utils__/**.@(js|ts|tsx)',
        '**/__fixtures__/**.@(js|ts|tsx)',
        'scripts/*.@(js|ts|tsx)',
      ],
      env: {
        jest: true,
      },
      extends: ['plugin:jest/recommended'],
      rules: {
        'jest/expect-expect': 'off',
        'jest/no-standalone-expect': 'off',
        'jest/no-disabled-tests': 'error',
        'jest/consistent-test-it': 'error',
        '@typescript-eslint/consistent-type-assertions': 'off',
        '@typescript-eslint/no-var-requires': 'off',
        '@typescript-eslint/explicit-function-return-type': 'off',

        // TODO(mc, 2021-01-29): fix these and remove warning overrides
        'jest/no-deprecated-functions': 'warn',
        'jest/valid-title': 'warn',
        'jest/no-conditional-expect': 'warn',
      },
    },
  ],
}
