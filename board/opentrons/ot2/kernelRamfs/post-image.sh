#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"

# rename the kernel so it does not get overwritten when the ot2_defconfig gets built
echo "renaming zImage to kernelRamfs"
mv ${BINARIES_DIR}/zImage ${BINARIES_DIR}/kernelRamfs
cp ${BOARD_DIR}/kernelRamfs.dtb ${BINARIES_DIR}
