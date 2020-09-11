# Buildroot (Opentrons fork)

This is the Opentrons fork of Buildroot, the embedded Linux system builder, which we use to configure and build the OT-2's operating system.

## (Highly) Recommended Reading

Working in this repository is easier if you are familiar with Buildroot.

- Documentation and users manual: <https://buildroot.org/docs.html>
- Upstream repository: <https://github.com/buildroot/buildroot/>
- Buildroot website: <https://buildroot.org/>

## Building Locally

We wrap the Buildroot build system in a [Docker][] container to manage dependencies and make it slightly more portable. Due to case-sensitive filenames and other concerns, the build must be run on Linux.

This fork requires the [opentrons repo](https://github.com/Opentrons/opentrons) to be checked out next to it, since it uses a Buildroot external toolchain to build in our dependencies.

[docker]: https://www.docker.com/

### Prerequisites

- Linux
  - If you are on another OS, you should use a local or cloud Linux virtual machine
  - A tool like [Vagrant][] can help with VM configuration and setup
- `docker`
- `git`

[vagrant]: https://www.vagrantup.com/

### Setup

In order to build, `docker` and `git` must be installed and the monorepo must be checked out as a neighbor to `buildroot`

```shell
# 0) clone the opentrons monorepo, if you haven't already
git clone https://github.com/Opentrons/opentrons.git

# 1) clone the Opentrons fork of buildroot next to the monorepo
git clone https://github.com/Opentrons/buildroot.git

# 2) navigate into the repository
cd buildroot
```

### Build

From `buildroot`, run the `./opentrons_build.sh` script. This will build a docker container and run a build in it using the Buildroot `Makefile`

```shell
# build all images
./opentrons_build.sh

# equivalent command
./opentrons_build.sh all
```

Buildroot caches build intermediates aggressively, but sometimes you need to run a full rebuild. Full rebuilds (as well as your very first builds) can take a long time, so avoid them if you can. The Buildroot docs explain [when a full rebuild is necessary][].

```shell
# run a full rebuild
./opentrons_build.sh "clean all"
```

[when a full rebuild is necessary]: https://buildroot.org/downloads/manual/manual.html#full-rebuild

### Outputs

The outputs of the build are

- A system image, `output/images/ot2-system.zip`, good for doing a software update
  - If your build is unsigned you will need to disable signature checking in the robot's update server config (`/var/lib/otupdate/config.json`) and restart it (`systemctl restart opentrons-update-server`).
- A full sd card image, `output/images/ot2-fullimage.zip`, good for burning a blank SD card
- A version file, `output/images/VERSION.json`, good for looking at the versions in the build

### Other Makefile Targets

`./opentrons_build.sh` will pass the last argument to the Buildroot `Makefile` and any preceding arguments, if they exist, to `docker run`. So, if you want to run multiple `make` targets at once, wrap your targets in quotation marks:

```shell
./opentrons-build.sh "python-opentrons-api all"
```

Certain tasks require terminal input and output. For those tasks, you should run `docker` in interactive TTY mode to use your terminal inside the container:

```shell
# pass "-it" to `docker run` and "menuconfig" to `make`
./opentrons-build.sh -it menuconfig
```

### Production Builds

You can control the release type with the `OT_BUILD_TYPE` environment variable. If you set this to `release`, the system will try and sign the output using a private key in the `SIGNING_KEY` environment variable. Generally, you should never be running production builds locally expect for build pipeline testing; the CI is where production builds happen.

```shell
# development build (default)
OT_BUILD_TYPE=dev ./opentrons_build.sh

# production build
OT_BUILD_TYPE=release SIGNING_KEY=super-secret ./opentrons_build.sh
```

The API key for our log aggregator, datadog, can be provided either by specifying it in the `DATADOG_API_KEY` environment variable or by having AWS credentials available to pull it (and `python3` and `boto3` installed). If not specified, the build will run and work, but that robot will be unable to upload logs to datadog.

```shell
# export data dog environment variable
export DATADOG_API_KEY=super-secret

# ...or pull datadog key from AWS credential store
pip3 install boto3
export AWS_ACCESS_KEY_ID=abc
export AWS_SECRET_ACCESS_KEY=xyz
```

## Adding Commits

As a fork of the Buildroot project, commits and commit messages should stick to the conventions outlined in the Buildroot manual. Changes to the build configuration should be documented in a commit message in the form of `configs/ot2_defconfig: select lib-foo`. Changes to available build packages should receive a commit message in the form of `package-name: (new,remove,update, etc.) package`.

Submitted pull requests should be made up of commits with messages that are suitable to be placed directly onto the head of `opentrons-develop`. Unlike the opentrons monorepo, we merge pull requests into this repository with a rebase merge instead of a squash merge. This means all commits will appear in the master branch once the PR is reviewed and accepted.

## Modifying Configuration

We use the `ot2` defconfig in `configs/ot2_defconfig`. This is where all the buildroot configuration should go. You can edit this file manually, but it is often easier to start by using the `menuconfig` tool.

### Using `menuconfig`

Buildroot includes a TUI application for modifying the defconfig file. Please note that you **should still inspect the defconfig** after it is generated, and you may need to make manual edits before it is ready for merge.

```shell
# 1. load configs/ot2_defconfig into .config prior to editing
./opentrons-build.sh -it ot2_defconfig

# 2. open .config in the menuconfig tool
./opentrons-build.sh -it menuconfig

# 3. save the changes to .config back into configs/ot2_defconfig
./opentrons-build.sh -it savedefconfig
```

## Provisioning an SD Card and Booting

Once built, the file `output/images/ot2-fullimage.zip` can be flashed to a microSD card and used in an OT-2 using [balenaEtcher][].

1. Open balenaEtcher
2. Select `path/to/buildroot/output/images/ot2-fullimage.zip`
3. Select your SD card writer
4. Click "Flash!"
5. When done, insert the SD card into your Raspberry Pi and boot your OT-2

To gain SSH access to the device, connect the Pi to your computer via an Ethernet cable and:

1. Use the [Opentrons App][] or the [standalone Discovery Client][] to get the link-local IP address of the Pi
2. Follow the [SSH setup][] guide to upload your SSH public key to the device

Note: **development builds include a default SSH public key** as part of the build located at `board/opentrons/ot2/rootfs-overlay/var/home/.ssh/robot_key.pub`.

[balenaetcher]: https://www.balena.io/etcher/
[opentrons app]: https://www.opentrons.com/ot-app/
[standalone discovery client]: https://github.com/Opentrons/discovery-client-standalone/
[ssh setup]: https://support.opentrons.com/en/articles/3203681

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
