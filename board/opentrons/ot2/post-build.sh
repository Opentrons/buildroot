#!/bin/sh

set -u
set -e

# Load the out-of-container env to get stuff from codebuild
export $(cat /buildroot/.env | xargs)

GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

# Write an fstab that will do our /var and bind mounts
cat <<EOF > ${TARGET_DIR}/etc/fstab
/dev/root / auto ro 0 0
/dev/mmcblk0p4 /var auto rw,x-systemd.growfs 0 2
/var/data /data none defaults,bind 0 0
/var/home /root none defaults,bind 0 0
/var/mnt /mnt none defaults,bind 0 0
EOF

# Get our kernel and dt(s) in rootfs
mkdir -p ${TARGET_DIR}/boot
cp ${BINARIES_DIR}/zImage ${TARGET_DIR}/boot/zImage
mkdir -p ${TARGET_DIR}/boot/overlays
mkdir -p ${TARGET_DIR}/mnt/bootpart
cp -r ${BINARIES_DIR}/rpi-firmware/overlays ${TARGET_DIR}/boot/overlays
cp -r ${BINARIES_DIR}/*.dtb ${TARGET_DIR}/boot/

# rewrite config.txt to boot u-boot
sed -i s/kernel=zImage/kernel=u-boot.bin/ ${BINARIES_DIR}/rpi-firmware/config.txt

if [ ${OT_BUILD_TYPE} != "release" ]; then
    echo "Build type is NOT RELEASE, adding default ssh key and removing signing"
    # write common pubkey to authorized keys
    cat ${TARGET_DIR}/var/home/.ssh/robot_key.pub > ${TARGET_DIR}/var/home/.ssh/authorized_keys
    # remove code signing cert (allows unsigned updates)
    rm ${TARGET_DIR}/etc/opentrons-robot-signing-key.crt
else
    echo "Build type is RELEASE"
fi

python ./board/opentrons/ot2/write_version.py ${BINARIES_DIR}/opentrons-api-version.json ${BINARIES_DIR}/opentrons-update-server-version.json ${BINARIES_DIR}/VERSION.json
cp ${BINARIES_DIR}/VERSION.json ${TARGET_DIR}/etc/VERSION.json

# manually make a softlink for /etc/dropbear because it needs to be absolute
# due to the logic in the dropbear system file, but if it was checked in it
# would be rewritten by aws
rm -f ${TARGET_DIR}/etc/dropbear
ln -sf /var/run/dropbear ${TARGET_DIR}/etc/dropbear
