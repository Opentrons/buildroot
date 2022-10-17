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

DOCKER_BR_BIND_DIR="/buildroot"
DOCKER_OT_BIND_DIR="/opentrons"
DOCKER_BIND_BR="--mount type=bind,source=$(pwd),destination=${DOCKER_BR_BIND_DIR},consistency=delegated"
DOCKER_BIND_OT="--mount type=bind,source=$(pwd)/../opentrons,destination=${DOCKER_OT_BIND_DIR},consistency=delegated"
DOCKER_BIND="${DOCKER_BIND_BR} ${DOCKER_BIND_OT}"
heads=${@:1:$(($# - 1))}
tail=${@:$#}

if [[ -n "${CI}" ]]; then
   filter_arg="--build-arg filter_output=true"
fi

if [[ -z "${DATADOG_API_KEY}" ]]; then
    export DATADOG_API_KEY=$(./get_parameter.py /buildroot-codebuild/datadog-api -)
fi

githubname="$(git describe --all --dirty --always | tr '[:upper:]' '[:lower:]')"
imgname=opentrons-buildroot-${githubname}

docker build ${filter_arg} -t ${imgname} .

# Save codebuild-relevant env vars to get them inside docker
env | grep 'CODEBUILD\|AWS\|DATADOG' > .env
echo "OT_BUILD_TYPE=${OT_BUILD_TYPE-dev}" >> .env
echo "FORCE_UNSAFE_CONFIGURE=1" >> .env

if [[ -n "${SIGNING_KEY}" ]]; then
    echo "${SIGNING_KEY}" > .signing-key
fi

case $# in
    0)
        echo "------------------------------------ KernelRamfs BUILD --------------------------------"
        docker run --env-file ./.env ${DOCKER_BIND} ${imgname} O=./output/kernelRamfs ot2_kernelramfs_defconfig
        docker run --env-file ./.env ${DOCKER_BIND} ${imgname} O=./output/kernelRamfs all

        echo "------------------------------------ REGULAR BUILD ------------------------------------"
        docker run --env-file ./.env ${DOCKER_BIND} ${imgname} O=./output/ot2 ot2_defconfig
        docker run --env-file ./.env ${DOCKER_BIND} ${imgname} O=./output/ot2 all 
        docker run --env-file ./.env ${DOCKER_BIND} ${imgname} O=./output/ot2 sdk
        ;;
    *)
        docker run --env-file ./.env ${heads} ${DOCKER_BIND} ${imgname} ${tail}
        ;;
esac
