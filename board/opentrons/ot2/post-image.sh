#!/bin/bash

set -e

# Load the out-of-container env to get stuff from codebuild
export $(cat /buildroot/.env | xargs)

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

sed -i -e 's/console=ttyAMA0,115200//' "${BINARIES_DIR}/rpi-firmware/cmdline.txt"

for arg in "$@"
do
	case "${arg}" in
		--add-pi3-miniuart-bt-overlay)
		if ! grep -qE '^dtoverlay=' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			echo "Adding 'dtoverlay=pi3-miniuart-bt' to config.txt (fixes ttyAMA0 serial console)."
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# fixes rpi3 ttyAMA0 serial console
dtoverlay=pi3-miniuart-bt
__EOF__
		fi
		;;
		--aarch64)
		# Run a 64bits kernel (armv8)
		sed -e '/^kernel=/s,=.*,=Image,' -i "${BINARIES_DIR}/rpi-firmware/config.txt"
		if ! grep -qE '^arm_64bit=1' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# enable 64bits support
arm_64bit=1
__EOF__
		fi

		# Enable uart console
		if ! grep -qE '^enable_uart=1' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# enable rpi3 ttyS0 serial console
enable_uart=1
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

echo "Generating fs and sd card images..."

rm -rf "${TARGET_DIR}/var"
mv "${GENIMAGE_TMP}/var" "${TARGET_DIR}/"

rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

echo "Generating hash for rootfs.ext4..."
shasum -a 256 ${BINARIES_DIR}/rootfs.ext4 | grep -oh "^.\+ " > ${BINARIES_DIR}/rootfs.ext4.hash

if [ ${OT_BUILD_TYPE} = "release" ]; then
    echo "Build type is RELEASE"
    echo "Signing rootfs hash"
    openssl dgst -sha256 -sign .signing-key -out ${BINARIES_DIR}/rootfs.ext4.hash.sig ${BINARIES_DIR}/rootfs.ext4.hash
    system_files="${BINARIES_DIR}/rootfs.ext4 ${BINARIES_DIR}/rootfs.ext4.hash ${BINARIES_DIR}/VERSION.json ${BINARIES_DIR}/rootfs.ext4.hash.sig"
else
    echo "Build type is NOT RELEASE"
    system_files="${BINARIES_DIR}/rootfs.ext4 ${BINARIES_DIR}/rootfs.ext4.hash ${BINARIES_DIR}/VERSION.json"
fi

echo "Zipping system image..."
rm -f ${BINARIES_DIR}/ot2-system.zip
zip -j ${BINARIES_DIR}/ot2-system.zip ${system_files}

echo "Zipping full sd card image..."
rm -f ${BINARIES_DIR}/ot2-fullimage.zip
zip -j ${BINARIES_DIR}/ot2-fullimage.zip ${BINARIES_DIR}/sdcard.img ${BINARIES_DIR}/VERSION.json


exit $?
