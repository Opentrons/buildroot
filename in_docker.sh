#!/usr/bin/env bash
# This script is invoked by the docker builder and wraps up configuring the
# defconfig and actually wrapping the build. It also limits the verbosity
# of the buildroot output by only passing lines from make and saving the
# rest to a file.
set -o pipefail
set -e
set -v

targets=$@
filtered_build_log="/buildroot/buildlog.txt"
filtered_warnings_log="/buildroot/warnings.txt"

function finish {
    if [[ -f "${filtered_warnings_log}" ]]; then
        cat ${filtered_warnings_log}
    fi
}

trap finish EXIT

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

echo "Unfiltered make"
BR2_EXTERNAL=/opentrons make -C /buildroot $@
