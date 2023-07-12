# Determining References To Build

This github action is used to determine which git references of the repos that go into an openembedded build to use, based on some of them being specified and others of them being left free. This allows us to start builds where we only specify the git refs that we care about, and leave the rest to be automatically decided following these rules:


- When a build is started, identify the "authoritative ref", which shall be the first of the following repos in order that is in `S: opentrons, buidlroot`. The authoritative ref is `A`.
  - For each repo in `S`, use the specified source revision
  - For each repo `Fi` in `F`
     - if `A` is the main branch of its repo (i.e. `edge` for monorepo, `opentrons-develop` for buildroot), use the main branch of `Fi`
     - if `A` is a branch that is not the main branch of its repo
       - and a branch of the same name exists in `Fi`, use that matching branch
       - and a branch of the same name does not exist in `Fi`, use the main branch of `Fi`
     - if `A` is a tag
       - and a tag of the same name exists in `Fi`, use that tag
       - and a tag of the same name does not exist in `Fi`, but other tags exist in `Fi`, use the latest tag in `Fi`
       - and a tag of the same name does not exist in `Fi` and there are no tags in `Fi`, use `Fi`'s main branch
       
# Developing

This github action is written in typescript. Github Actions doesn't support typescript, it supports javascript. So the action is transpiled, which means there's a whole huge project setup to handle it.

There's a package.json here which means you can (and should) `npm install` in this repo to get it set up. Use node 16.

After that, `npm run build` will transpile the code to js in `dist/`. This needs to be checked in.

- `npm run lint` lints
- `npm run format` formats
- `npm run test` runs tests with jest

If you forget to build and check in the result, github actions will do it for you.
