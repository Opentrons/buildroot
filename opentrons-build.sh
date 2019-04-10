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

# Note also that if there are no arguments, the script will do the proper
# sequence of invocations to build buildroot from a fresh clone (e.g. two
# make invocations, one for defconfig and one for build); when arguments
# are provided, it will run the docker container once with the arguments
set -e -o pipefail

function finish {
    rm -f .signing-key
    exit $?
}

trap finish EXIT

DOCKER_BR_BIND_DIR="/buildroot"
DOCKER_OT_BIND_DIR="/opentrons"
DOCKER_BIND_BR="--mount type=bind,source=$(pwd),destination=${DOCKER_BR_BIND_DIR}"
DOCKER_BIND_OT="--mount type=bind,source=$(pwd)/../opentrons,destination=${DOCKER_OT_BIND_DIR}"
DOCKER_BIND="${DOCKER_BIND_BR} ${DOCKER_BIND_OT}"
heads=${@:1:$(($# - 1))}
tail=${@:$#}

if [ -n "$CI" ]
   then
   filter_arg="--build-arg filter_output=true"
fi

imgname=opentrons-buildroot-$(git describe --all --dirty --always)

docker build ${filter_arg} -t ${imgname} .

# Save codebuild-relevant env vars to get them inside docker
env | grep 'CODEBUILD\|AWS' >.env
echo "OT_BUILD_TYPE=${OT_BUILD_TYPE-dev}">>.env
echo "${SIGNING_KEY}" > .signing-key

case $# in
    0)
        docker run ${DOCKER_BIND} ${imgname} ot2_defconfig
        docker run ${DOCKER_BIND} ${imgname} all
        ;;
    *)
        docker run ${heads} ${DOCKER_BIND} ${imgname} ${tail}
        ;;
esac
