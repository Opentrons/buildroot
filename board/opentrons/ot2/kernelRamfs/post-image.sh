#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"

echo "Copy kernelRamfs and dtb to kernelramfs_bin"
mkdir -p ./kernelramfs_bin
cp ${BINARIES_DIR}/zImage ./kernelramfs_bin/kernelRamfs
cp ${BINARIES_DIR}/bcm2710-rpi-3-b-plus.dtb ./kernelramfs_bin/kernelRamfs.dtb
