# Buildroot (Opentrons fork)

This is the Opentrons fork of buildroot, the embedded linux system builder. The upstream project can be found at https://github.com/buildroot/buildroot/ or https://buildroot.org/. The manual can be found at https://buildroot.org/downloads/manual/ - it’s probably a good idea to give https://buildroot.org/downloads/manual/manual.html a quick browse.

## Building

We wrap the buildroot build system in a docker container to manage dependencies and make it slightly more portable. People have had problems building this repo on things other than Linux, however, and that remains really the only supported build platform - but it probably works on other platforms too.

This fork requires the [opentrons repo](https://github.com/Opentrons/opentrons) to be checked out next to it, since it uses a buildroot external toolchain to build in our dependencies.

To build, make sure ``docker`` and ``git`` are installed, and the monorepo is checked out as a neighbor, and run ``./opentrons_build.sh``. This will build the docker container and run a build in it.

You can build other Buildroot makefile targets using this script by putting them in the last argument. The arguments are split so that the last argument is passed to the makefile and the first arguments are passed to docker. That means if you want to build the targets ``python-opentrons-api`` and ``all`` (``all`` is how you get images out) you would do ``./opentrons-build.sh "python-opentrons-api all"``. If you wanted to run menuconfig, you would run ``./opentrons-build.sh -ti menuconfig``, so docker gave you a terminal and the makefile runs menuconfig

You can control the release type with the ``OT2_BUILD_TYPE`` environment variable. If you set this to ``release``, the system will try and sign the output using a private key in the ``SIGNING_KEY`` environment variable.

## Outputs

The outputs of the build are

- A system image, ``output/images/ot2-system.zip``, good for doing a software update
- A full sd card image, ``output/images/ot2-fullimage.zip``, good for burning a blank SD card
- a version file, ``output/images/VERSION.json``, good for looking at the versions in the build


## Configuration

We use the ``ot2`` defconfig in ``configs/ot2_defconfig``. This is where all the buildroot configuration should go.
