#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

sed -i -e 's/console=ttyAMA0,115200//' "${BINARIES_DIR}/rpi-firmware/cmdline.txt"

for arg in "$@"
do
	case "${arg}" in
		--aarch64)
		# Run a 64bits kernel (armv8)
		sed -e '/^kernel=/s,=.*,=Image,' -i "${BINARIES_DIR}/rpi-firmware/config.txt"
		if ! grep -qE '^arm_64bit=1' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# enable 64bits support
arm_64bit=1
__EOF__
		fi
		;;
		--gpu_mem_256=*|--gpu_mem_512=*|--gpu_mem_1024=*)
		# Set GPU memory
		gpu_mem="${arg:2}"
		sed -e "/^${gpu_mem%=*}=/s,=.*,=${gpu_mem##*=}," -i "${BINARIES_DIR}/rpi-firmware/config.txt"
		;;
	esac

done


dtc -@ -I dts -O dtb -o "${BINARIES_DIR}/rpi-firmware/overlays/gpio-revision-bits.dtbo" "${BOARD_DIR}/gpio-revision-bits.dts"

dtc -@ -I dts -O dtb -o "${BINARIES_DIR}/rpi-firmware/overlays/i2c-rtc-rv3028.dtbo" "${BOARD_DIR}/i2c-rtc-rv3028.dts"

dtc -@ -I dts -O dtb -o "${BINARIES_DIR}/rpi-firmware/overlays/ot2-disable-bt.dtbo" "${BOARD_DIR}/ot2-disable-bt.dts"
dtc -@ -I dts -O dtb -o "${BINARIES_DIR}/rpi-firmware/overlays/ot2-miniuart-bt.dtbo" "${BOARD_DIR}/ot2-miniuart-bt.dts"


echo "Generating fs and sd card images..."

rm -rf "${TARGET_DIR}/var"
mv "${GENIMAGE_TMP}/var" "${TARGET_DIR}/"

rm -rf "${GENIMAGE_TMP}"

cp ${TARGET_DIR}/etc/hostname ${TARGET_DIR}/var/hostname
cp ${TARGET_DIR}/etc/machine-info ${TARGET_DIR}/var/machine-info

mkdir -p ${TARGET_DIR}/padding

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

echo "Generating hash for rootfs.ext4..."
shasum -a 256 ${BINARIES_DIR}/rootfs.ext4 | grep -oh "^.\+ " > ${BINARIES_DIR}/rootfs.ext4.hash

echo "Generating hash for boot.vfat..."
shasum -a 256 ${BINARIES_DIR}/boot.vfat | grep -oh "^.\+ " > ${BINARIES_DIR}/boot.vfat.hash

boot_files="${BINARIES_DIR}/boot.vfat ${BINARIES_DIR}/boot.vfat.hash"

if [ ${OT_BUILD_TYPE} = "release" ]; then
    echo "Build type is RELEASE"
else
    echo "Build type is NOT RELEASE"
fi

if [ -e .signing-key ]; then
    echo "Signing rootfs hash"
    openssl dgst -sha256 -sign .signing-key -out ${BINARIES_DIR}/rootfs.ext4.hash.sig ${BINARIES_DIR}/rootfs.ext4.hash
    system_files="${BINARIES_DIR}/rootfs.ext4 ${BINARIES_DIR}/rootfs.ext4.hash ${BINARIES_DIR}/VERSION.json ${BINARIES_DIR}/rootfs.ext4.hash.sig ${boot_files}"
else
    echo "signing key unavailable, build will not be signed"
    system_files="${BINARIES_DIR}/rootfs.ext4 ${BINARIES_DIR}/rootfs.ext4.hash ${BINARIES_DIR}/VERSION.json ${boot_files}"
fi

echo "Zipping system image at ${BINARIES_DIR}/ot2-system.zip..."
rm -f ${BINARIES_DIR}/ot2-system.zip
zip -j ${BINARIES_DIR}/ot2-system.zip ${system_files} ${BINARIES_DIR}/VERSION.json ${BINARIES_DIR}/release-notes.md

echo "Zipping full sd card image at ${BINARIES_DIR}/ot2-fullimage.zip..."
rm -f ${BINARIES_DIR}/ot2-fullimage.zip
zip -j ${BINARIES_DIR}/ot2-fullimage.zip ${BINARIES_DIR}/sdcard.img ${BINARIES_DIR}/VERSION.json ${BINARIES_DIR}/release-notes.md
exit $?
