################################################################################
#
# opentrons-temperature-module-firmware
#
################################################################################

OPENTRONS_TEMPERATURE_MODULE_FIRMWARE_VERSION=v2.0.1
OPENTRONS_TEMPERATURE_MODULE_FIRMWARE_SOURCE=temp-deck-arduino.ino.hex
OPENTRONS_TEMPERATURE_MODULE_FIRMWARE_SITE=https://opentrons-modules-builds.s3.us-east-2.amazonaws.com/temperature-module/$(OPENTRONS_TEMPERATURE_MODULE_FIRMWARE_VERSION)
OPENTRONS_TEMPERATURE_MODULE_FIRMWARE_LICENSE=Apache-2.0

# not downloaded in a tarball so don't extract
define OPENTRONS_TEMPERATURE_MODULE_FIRMWARE_EXTRACT_CMDS
	echo "Nothing to extract"
endef

define OPENTRONS_TEMPERATURE_MODULE_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(OPENTRONS_TEMPERATURE_MODULE_FIRMWARE_DL_DIR)/$(OPENTRONS_TEMPERATURE_MODULE_FIRMWARE_SOURCE) $(TARGET_DIR)/usr/lib/firmware/temperature-module@$(OPENTRONS_TEMPERATURE_MODULE_FIRMWARE_VERSION).hex
endef

$(eval $(generic-package))
