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
}

trap finish EXIT

if [ ! -d $(pwd)/../buildroot-upstream ] ; then
    echo "buildroot-upstream is not present, run ./checkout-buildroot.sh"
    exit 1
fi
if [ ! -d $(pwd)/../opentrons ] ; then
    echo "opentrons is not present, check it out as a sibling to this directory"
    exit 1
fi

DOCKER_BR_BIND_DIR="/buildroot"
DOCKER_OT_BIND_DIR="/opentrons"
DOCKER_BR_OVERLAYS_BIND_DIR="/buildroot-overlays"
DOCKER_BIND_BR="--mount type=bind,source=$(pwd)/../buildroot-upstream,destination=${DOCKER_BR_BIND_DIR},consistency=delegated"
DOCKER_BIND_BR_OVERLAYS="--mount type=bind,source=$(pwd),destination=${DOCKER_BR_OVERLAYS_BIND_DIR},consistency=delegated"
DOCKER_BIND_OT="--mount type=bind,source=$(pwd)/../opentrons,destination=${DOCKER_OT_BIND_DIR},consistency=delegated"
DOCKER_BIND="${DOCKER_BIND_BR} ${DOCKER_BIND_OT} ${DOCKER_BIND_BR_OVERLAYS}"
heads=${@:1:$(($# - 1))}
tail=${@:$#}

if [[ -z "${DATADOG_API_KEY}" ]]; then
    export DATADOG_API_KEY=$(./get_parameter.py /buildroot-codebuild/datadog-api -)
fi


imgname=$(./opentrons-build-container.sh pull || ./opentrons-build-container.sh build)

# Save codebuild-relevant env vars to get them inside docker
env | grep 'CODEBUILD\|AWS\|DATADOG' > .env
echo "OT_BUILD_TYPE=${OT_BUILD_TYPE-dev}" >> .env
echo "FORCE_UNSAFE_CONFIGURE=1" >> .env

if [[ -n "${SIGNING_KEY}" ]]; then
    echo "${SIGNING_KEY}" > .signing-key
fi

case $# in
    0)
        docker run --env-file ./.env ${DOCKER_BIND} --entrypoint=/buildroot-overlays/in_docker.sh ${imgname} ot2_defconfig
        docker run --env-file ./.env ${DOCKER_BIND} --entrypoint=/buildroot-overlays/in_docker.sh ${imgname} all
        ;;
    *)
        docker run --env-file ./.env ${heads} ${DOCKER_BIND} --entrypoint=/buildroot-overlays/in_docker.sh ${imgname} ${tail}
        ;;
esac
