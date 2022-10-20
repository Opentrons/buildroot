#!/bin/bash

set -e

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
/dev/mmcblk0p6 /var auto rw,x-systemd.growfs 0 2
/var/data /data none defaults,bind 0 0
/var/home /root none defaults,bind 0 0
/var/mnt /mnt none defaults,bind 0 0
/var/hostname /etc/hostname none defaults,bind,nofail 0 0
/var/machine-info /etc/machine-info none defaults,bind,nofail 0 0
EOF

# Get our kernel and dt(s) in rootfs
mkdir -p ${TARGET_DIR}/boot

# The KernelRamfs is a minimal kernel + initramfs whos purpose is to update
# the boot partition. The primary use case for this is to update from pre-6.2
# since update the kernel + dtb + overlays, pre-6.2 systems dont have these files
# in the boot partition, which causes the system to hang after post-6.2 update.

# If we are updating from pre-6.2, after the rootfs has been written to the
# inactive partition and the device reboots u-boot will look for the kernel
# /boot/zImage. Since /boot/zImage is now a symlink to 'kernelRamfs' the system
# will boot into kernelRamfs, which starts the pdate process. Once we are in the
# KernelRamfs, the init script will copy the dtb + overlays + config.txt + boot.scr
# in the rootfs to the boot partition. Finally we reboot, since we updated the boot.scr
# script this changes the boot logic. Now the new boot.scr looks for /boot/kernel
# in the partition determined by the 'ot2part' u-boot env variable, which will boot
# into the regular opentrons post-6.2 kernel.

# The 'kernelramfs' uboot env variable changes the boot target based on the following values
# kernelramfs = "0"   - load kernel at /boot/kernel
# kernelramfs = "1"   - load kernelRamfs at /boot/kernelRamfs and drop into recovery shell
# kernelramfs > "1"   - load kernelRamfs at /boot/kernelRamfs and update the boot partition
#                       with the contents of the /boot dir in the active rootfs partition (2,3)
#                       as determined by the 'ot2part' u-boot env variable.

# copy the KernelRamfs + dtb to boot dir
cp ./kernelramfs_bin/kernelRamfs ${TARGET_DIR}/boot/
cp ./kernelramfs_bin/kernelRamfs.dtb ${TARGET_DIR}/boot/
# create copy of dtb so genimage can include it in the boot partition
cp ./kernelramfs_bin/kernelRamfs.dtb ${BINARIES_DIR}/kernelRamfs.dtb

# create symlink of kernelRamfs so updating from pre-6.2 is possible
ln -sf kernelRamfs ${TARGET_DIR}/boot/zImage

# copy the actual kernel
cp ${BINARIES_DIR}/zImage ${TARGET_DIR}/boot/kernel

# copy the config.txt + boot.scr to boot dir
cp ./board/opentrons/ot2/config.txt ${TARGET_DIR}/boot/
cp ${BINARIES_DIR}/boot.scr ${TARGET_DIR}/boot/

mkdir -p ${TARGET_DIR}/boot/overlays
mkdir -p ${TARGET_DIR}/mnt/bootpart
cp -r ${BINARIES_DIR}/rpi-firmware/overlays ${TARGET_DIR}/boot/overlays
cp -r ${BINARIES_DIR}/*.dtb ${TARGET_DIR}/boot/

hostname_to_write=$(cat ${TARGET_DIR}/etc/hostname)

if [ "${OT_BUILD_TYPE}" != "release" ]; then
    echo "Build type is NOT RELEASE, adding default ssh key and removing signing"
    # write common pubkey to authorized keys
    cat ${TARGET_DIR}/var/home/.ssh/robot_key.pub > ${TARGET_DIR}/var/home/.ssh/authorized_keys
    deployment_to_write="development"

else
    echo "Build type is RELEASE"
    deployment_to_write="production"
fi

if [ ! -e .signing-key ]; then
    echo "No signing key present, removing cert"
    # remove code signing cert (allows unsigned updates)
    rm ${TARGET_DIR}/etc/opentrons-robot-signing-key.crt
fi

cat <<EOF >> "${TARGET_DIR}/etc/machine-info"
PRETTY_HOSTNAME=${hostname_to_write}
DEPLOYMENT=${deployment_to_write}
EOF

# Start avahi-daemon as late as possible so it catches hostnamed changing
# the hostname
if [[ -f ${TARGET_DIR}/etc/systemd/system/multi-user.target.wants/avahi-daemon.service ]]; then
    mv ${TARGET_DIR}/etc/systemd/system/multi-user.target.wants/avahi-daemon.service ${TARGET_DIR}/etc/systemd/system/opentrons.target.wants/avahi-daemon.service
fi

python ./board/opentrons/ot2/write_version.py ${BINARIES_DIR}/opentrons-api-version.json ${BINARIES_DIR}/opentrons-update-server-version.json ${BINARIES_DIR}/opentrons-robot-server-version.json ${BINARIES_DIR}/opentrons-notify-server-version.json ${BINARIES_DIR}/VERSION.json
cp ${BINARIES_DIR}/VERSION.json ${TARGET_DIR}/etc/VERSION.json

# Dropbear stores its host keys in /etc/dropbear, and the stock Buildroot
# scripts make that a symlink to /var/run/dropbear.  Replace that with a link
# to /var/lib/dropbear, on our RW partition, so the host keys persist across
# reboots and upgrades.
# 
# See also: rootfs-overlay/etc/systemd/system/dropbear.service.d/create-host-key-directory.conf.
# 
# Also, create the link manually in this script, rather than putting it in the
# rootfs overlay, so that AWS CodeBuild doesn't rewrite it to be relative.
rm -f ${TARGET_DIR}/etc/dropbear
ln -s /var/lib/dropbear ${TARGET_DIR}/etc/dropbear


# Syslog-ng extra setup:
# - install the datadog api key

echo "@define datadog_api_key \"${DATADOG_API_KEY}\"" > ${TARGET_DIR}/etc/syslog-ng/api_key.conf
mkdir -p ${TARGET_DIR}/etc/syslog-ng/certs.d/
rm -rf ${TARGET_DIR}/etc/syslog-ng/certs.d/*
curl https://docs.datadoghq.com/resources/crt/FULL_intake.logs.datadoghq.com.crt > ${TARGET_DIR}/etc/syslog-ng/certs.d/datadoghq.com.crt
