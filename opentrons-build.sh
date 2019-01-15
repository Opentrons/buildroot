#!/bin/bash
# This script is the top level build script for devs to use when doing manual
# builds so they don’t have to remember the multiple docker steps or arguments
# to bind mount the buildroot source.
#
# The script pipes its arguments to the eventual docker run invocation that
# runs buildroot’s make. The final argument is the argument to buildroot’s
# makefile; all others are inserted into the docker run command. For instance,
# to build a specific defconfig you could do
# ./opentrons-build.sh raspberrypi3_defconfig
# And to just get a shell in the docker container you could do
# ./opentrons-build.sh -ti --entrypoint /bin/bash ""
# The final empty quote marks are necessary for the script to correctly parse
# the arguments.
set -e -o pipefail

DOCKER_BIND="--mount type=bind,source=$(pwd),destination=/buildroot"
heads=${@:1:$(($# - 1))}
tail=${@:$#}

imgname=opentrons-buildroot-$(git describe --all --dirty --always)

echo "docker build -t ${imgname}" && docker build -t ${imgname} .
echo "docker run ${heads}${DOCKER_BIND} ${imgname} ${tail}" && docker run ${heads} ${DOCKER_BIND} ${imgname} ${tail}
