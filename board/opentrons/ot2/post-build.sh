#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

cat <<EOF > ${TARGET_DIR}/etc/fstab
/dev/root / auto ro 0 1
/dev/mmcblk0p4 /var auto rw 0 2
/var/data /data none defaults,bind 0 0
/var/home /home none defaults,bind 0 0
EOF
