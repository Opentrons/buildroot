#!/usr/bin/env sh
BUILDROOT_SIBLING_DIR="../buildroot-upstream"
BUILDROOT_VERSION=$(cat ./buildroot-upstream-ref)

if [ -e ${BUILDROOT_SIBLING_DIR} ] ; then
    echo "../buildroot-upstream exists, removing it"
    rm -rf ${BUILDROOT_SIBLING_DIR}
fi

echo "checking out ../buildroot-upstream at ${BUILDROOT_VERSION}"
git -C ../ clone https://github.com/buildroot/buildroot.git --branch=${BUILDROOT_VERSION} --depth=1 ./buildroot-upstream
