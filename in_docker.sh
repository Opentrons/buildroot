#!/usr/bin/env bash
# This script is invoked by the docker builder and wraps up configuring the
# defconfig and actually wrapping the build. It also limits the verbosity
# of the buildroot output by only passing lines from make and saving the
# rest to a file.
set -o pipefail
set -e
set -v

filtered_build_log="/buildroot/buildlog.txt"


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
       esac
   done;
fi

git config --global --add safe.directory /opentrons
git config --global --add safe.directory /buildroot

if [[ -z "${filter}" ]]; then
    echo "Unfiltered make"
    LANG="en_US.UTF-8" BR2_EXTERNAL=/opentrons make -C /buildroot "$@"
else
    echo "Filtered make"
    LANG="en_US.UTF-8" BR2_EXTERNAL=/opentrons make -C /buildroot "$@" 2> >(tee -a ${filtered_build_log}) > ${filtered_build_log}
fi
