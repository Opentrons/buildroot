#!/bin/bash

set -e

# rename the kernel so it does not get overwritten when the ot2_defconfig gets built
echo "renaming zImage to tinyKernel"
mv ${BINARIES_DIR}/zImage ${BINARIES_DIR}/tinyKernel
