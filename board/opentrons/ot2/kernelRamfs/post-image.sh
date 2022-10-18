#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"

echo "Copy kernelRamfs kernelramfs_bin"
mkdir -p ./kernelramfs_bin
cp ${BINARIES_DIR}/zImage ./kernelramfs_bin/kernelRamfs
