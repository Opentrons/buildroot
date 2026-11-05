#!/usr/bin/env bash
# This script is invoked by the docker builder and wraps up configuring the
# defconfig and actually wrapping the build. It also limits the verbosity
# of the buildroot output by only passing lines from make and saving the
# rest to a file.
set -o pipefail
set -e
set -v

filtered_build_log="/buildroot-overlays/buildlog.txt"

git config --global --add safe.directory /opentrons
git config --global --add safe.directory /buildroot
git config --global --add safe.directory /buildroot-overlays
git config --global user.email "engineering@opentrons.com"
git config --global user.name "Opentrons CI"

function do_unpatch {
    echo "git -C /buildroot reset --hard $(cat /buildroot-overlays/buildroot-upstream-ref)"
    git -C /buildroot reset --hard $(cat /buildroot-overlays/buildroot-upstream-ref)
}

function do_patch {
    echo "git -C /buildroot am $* /buildroot-overlays/upstream-patches/*.patch"
    git -C /buildroot am $* /buildroot-overlays/upstream-patches/*.patch
}

trap do_unpatch EXIT
do_patch


if [[ -n "${FILTER}" ]]; then
   echo "in ci"
   for w in $@; do
       case "$w" in
           "all")
               filter=1
               ;;
           "packages")
               filter=1
               ;;
           "toolchain")
               filter=1
               ;;
           "/bin/bash")
               term=1
               ;;
           "cyclone")
               cyclone=1
               ;;
       esac
   done;
fi

if [[ -n "${term}" ]]; then
    echo "term"
    /bin/bash -i
elif [[ -n "${cyclone}" ]]; then
    echo "SBOM generation to ${O:-/output}/projinfo.json using ${O}/.config"
    echo $(head ${O:-/output}/.config)
    O=${O:-/output} LC_CTYPE="en_US.UTF-8" LANGUAGE="en_US.UTF-8" LC_ALL="C" LANG="en_US.UTF-8" BR2_EXTERNAL=/buildroot-overlays:/opentrons make -C /buildroot show-info > "${O:-/output}/projinfo.json"
    /buildroot/utils/generate-cyclonedx \
        -i "${O:-/output}/projinfo.json" \
        -o "${O:-/output}/opentrons-ot2.cln.json" \
        -n "Opentrons OT-2" \
        --cdx-version=1.7.1 \


elif [[ -z "${filter}" ]]; then
    echo "Unfiltered make"
    LC_CTYPE="en_US.UTF-8" LANGUAGE="en_US.UTF-8" LC_ALL="C" LANG="en_US.UTF-8" BR2_EXTERNAL=/buildroot-overlays:/opentrons make -C /buildroot "$@"
else
    echo "Filtered make"
    LC_CTYPE="en_US.UTF-8" LANGUAGE="en_US.UTF-8" LC_ALL="C" LANG="en_US.UTF-8" BR2_EXTERNAL=/buildroot-overlays:/opentrons KBUILD_VERBOSE=1 make -C /buildroot "$@" 2> >(tee -a ${filtered_build_log}) > ${filtered_build_log}
fi
