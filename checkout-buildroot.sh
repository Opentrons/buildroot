#!/usr/bin/env sh
BUILDROOT_SIBLING_DIR="../buildroot-upstream"
BUILDROOT_VERSION="2023.02.5"

if [ -e ${BUILDROOT_SIBLING_DIR} ] ; then
    echo "../buildroot-upstream exists, removing it"
    rm -rf ${BUILDROOT_SIBLING_DIR}
fi

echo "checking out ../buildroot-upstream"
git -C ../ clone https://github.com/buildroot/buildroot.git --branch=${BUILDROOT_VERSION} --depth=1 ./buildroot-upstream
