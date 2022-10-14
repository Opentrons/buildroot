# create ramdisk

# remove these
echo "IM IN FAKEROOT"
ls "${TARGET_DIR}"
rm -rf "${TARGET_DIR}/media
rm -rf "${TARGET_DIR}/opt
rm -rf "${TARGET_DIR}/root
rm -rf "${TARGET_DIR}/var
rm -rf "${TARGET_DIR}/data
rm -rf "${TARGET_DIR}/mnt
ls "${TARGET_DIR}"
