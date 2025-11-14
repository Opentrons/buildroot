set -ev
# remove __pycaches__ since they just take space
find ${TARGET_DIR}/usr/lib/python3.12/site-packages -name __pycache__ -delete

# Remove /var from rootfs because it will be in its own partition
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
mkdir -p "${GENIMAGE_TMP}"
rm -rf "${GENIMAGE_TMP}/var"
mv "${TARGET_DIR}/var" "${GENIMAGE_TMP}/"
mkdir -p "${TARGET_DIR}/var"
