#!/bin/bash

set -e

# set changes here

# Add a console on tty1
#if [ -e ${TARGET_DIR}/etc/inittab ]; then
#   grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
#        sed -i '/GENERIC_SERIAL/a\
#tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
#fi

# Write an fstab that will mount boot partition
#cat <<EOF > ${TARGET_DIR}/etc/fstab
#/dev/root / auto ro 0 0
#/dev/mmcblk0p1 /var auto rw 0 2
#EOF
#
