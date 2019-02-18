#!/usr/bin/env bash
# This script is invoked by the docker builder and wraps up configuring the
# defconfig and actually wrapping the build. It also limits the verbosity
# of the buildroot output by only passing lines from make and saving the
# rest to a file.
set -o pipefail
set -e
set -v
targets=$@
if [ -n "$FILTER" ]
then
   echo "in ci"
   for w in $@
   do
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

if [ -z $filter ]
then
    echo "Unfiltered make"
    make -C /buildroot $@
else
    echo "Filtered make"
    (make -C /buildroot $@ 2>/buildroot/warnings.txt | awk '/^make/;{print $0 >>"/buildroot/buildlog.txt"}') || cat warnings.txt
fi
