# Buildroot (Opentrons fork)

This is the Opentrons fork of buildroot, the embedded linux system builder. The upstream project can be found at https://github.com/buildroot/buildroot/ or https://buildroot.org/. The manual can be found at https://buildroot.org/downloads/manual/ - it’s probably a good idea to give https://buildroot.org/downloads/manual/manual.html a quick browse.

## Building Locally

We wrap the buildroot build system in a docker container to manage dependencies and make it slightly more portable. People have had problems building this repo on things other than Linux, however, and that remains really the only supported build platform - but it probably works on other platforms too.

This fork requires the [opentrons repo](https://github.com/Opentrons/opentrons) to be checked out next to it, since it uses a buildroot external toolchain to build in our dependencies.

To build, make sure ``docker`` and ``git`` are installed, and the monorepo is checked out as a neighbor, and run ``./opentrons_build.sh``. This will build the docker container and run a build in it.

The API key for our log aggregator, datadog, can be provided either by specifying it in the ``DATADOG_API_KEY`` env var or by having aws creds available to pull it (and python3 and boto3 installed). If not specified, the build will run and work, but that robot will be unable to upload logs to datadog.

You can build other Buildroot makefile targets using this script by putting them in the last argument. The arguments are split so that the last argument is passed to the makefile and the first arguments are passed to docker. That means if you want to build the targets ``python-opentrons-api`` and ``all`` (``all`` is how you get images out) you would do ``./opentrons-build.sh "python-opentrons-api all"``. If you wanted to run menuconfig, you would run ``./opentrons-build.sh -ti menuconfig``, so docker gave you a terminal and the makefile runs menuconfig

You can control the release type with the ``OT2_BUILD_TYPE`` environment variable. If you set this to ``release``, the system will try and sign the output using a private key in the ``SIGNING_KEY`` environment variable.

## Outputs

The outputs of the build are

- A system image, ``output/images/ot2-system.zip``, good for doing a software update
- A full sd card image, ``output/images/ot2-fullimage.zip``, good for burning a blank SD card
- a version file, ``output/images/VERSION.json``, good for looking at the versions in the build


## Configuration

We use the ``ot2`` defconfig in ``configs/ot2_defconfig``. This is where all the buildroot configuration should go.

## Automated Builds and Deployment

We have integrations set up to build this repo in AWS Codebuild, which can build release or non-release builds. Release builds have the public cert for our signing key included, have signatures for the update files, and do not ship with an ssh public key already installed. Non-release builds do not have the signing key cert, do not have signatures, and ship with a default ssh public key for testing.

The repo is built automatically

- When any new object is pushed to this repo (non-release); this uses the current head of `edge` from the monorepo for the API server and update server
- When new commits are pushed to the `edge` branch of the monorepo (non-release), using the `opentrons-develop` branch of this repo
- When new commits are pushed to a branch of the monorepo that has a matching branch in this repo (non-release)
- When a tag is pushed to the monorepo (release), using the latest github release in this repo

When builds complete, they are uploaded to an s3 bucket prefixed by the codebuild build id (see the buildspec file). If the build was a release build, the manifest `releases.json` in the root of the bucket is updated so that the key path `/production/{monorepo-version}` contains a dict mapping `system'` to the path of the update file zip, `'fullImage'` to the path of the provisioning zip, and `'version'` to the path of the version file. For instance, the manifest might look like

```json
{
  "production": {
    "3.8.3": {
      "fullImage": "https://opentrons-buildroot-ci.s3.amazonaws.com/ebc9f421-04db-4ec8-87bd-f990c69bbd80/opentrons-buildroot/ot2-fullimage.zip",
      "system": "https://opentrons-buildroot-ci.s3.amazonaws.com/ebc9f421-04db-4ec8-87bd-f990c69bbd80/opentrons-buildroot/ot2-system.zip",
      "version": "https://opentrons-buildroot-ci.s3.amazonaws.com/ebc9f421-04db-4ec8-87bd-f990c69bbd80/opentrons-buildroot/VERSION.json"
    }
  }
}
```
