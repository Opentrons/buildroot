include $(sort $(wildcard $(BR2_EXTERNAL_OPENTRONS_BUILDROOT_OVERLAYS_PATH)/toolchain/*/*.mk))
include $(sort $(wildcard $(BR2_EXTERNAL_OPENTRONS_BUILDROOT_OVERLAYS_PATH)/package/pkg-*.mk))
include $(sort $(wildcard $(BR2_EXTERNAL_OPENTRONS_BUILDROOT_OVERLAYS_PATH)/package/*/*.mk))
