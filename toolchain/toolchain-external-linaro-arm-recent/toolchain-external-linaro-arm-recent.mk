################################################################################
#
# toolchain-external-linaro-arm-recent
#
################################################################################

TOOLCHAIN_EXTERNAL_LINARO_ARM_RECENT_VERSION = 14.3.rel1
TOOLCHAIN_EXTERNAL_LINARO_ARM_RECENT_SITE = https://developer.arm.com/-/media/Files/downloads/gnu/$(TOOLCHAIN_EXTERNAL_LINARO_ARM_RECENT_VERSION)/binrel

TOOLCHAIN_EXTERNAL_LINARO_ARM_RECENT_SOURCE = arm-gnu-toolchain-$(TOOLCHAIN_EXTERNAL_LINARO_ARM_RECENT_VERSION)-x86_64-arm-none-linux-gnueabihf.tar.xz


$(eval $(toolchain-external-package))
