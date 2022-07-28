################################################################################
#
# opentrons-heater-shaker-firmware
#
################################################################################

OPENTRONS_HEATER_SHAKER_FIRMWARE_VERSION=v0.4.23
OPENTRONS_HEATER_SHAKER_FIRMWARE_SOURCE=heater-shaker@v0.4.23.bin
OPENTRONS_HEATER_SHAKER_FIRMWARE_SITE=https://opentrons-modules-builds.s3.us-east-2.amazonaws.com/heater-shaker/$(OPENTRONS_HEATER_SHAKER_FIRMWARE_VERSION)
OPENTRONS_HEATER_SHAKER_FIRMWARE_LICENSE=Apache-2.0

# not downloaded in a tarball so don't extract
define OPENTRONS_HEATER_SHAKER_FIRMWARE_EXTRACT_CMDS
	echo "Nothing to extract"
endef

define OPENTRONS_HEATER_SHAKER_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(OPENTRONS_HEATER_SHAKER_FIRMWARE_DL_DIR)/$(OPENTRONS_HEATER_SHAKER_FIRMWARE_SOURCE) $(TARGET_DIR)/usr/lib/firmware/heater-shaker@$(OPENTRONS_HEATER_SHAKER_FIRMWARE_VERSION).bin
endef

$(eval $(generic-package))
