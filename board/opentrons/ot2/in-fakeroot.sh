# Remove /var from rootfs because it will be in its own partition
set -ev
rm -rf ${TARGET_DIR}/var/*
