################################################################################
#
# opentrons-magnetic-module-firmware
#
################################################################################

OPENTRONS_MAGNETIC_MODULE_FIRMWARE_VERSION=v2.0.0
OPENTRONS_MAGNETIC_MODULE_FIRMWARE_SOURCE=mag-deck-arduino.ino.hex
OPENTRONS_MAGNETIC_MODULE_FIRMWARE_SITE=https://opentrons-modules-builds.s3.us-east-2.amazonaws.com/magnetic-module/$(OPENTRONS_MAGNETIC_MODULE_FIRMWARE_VERSION)
OPENTRONS_MAGNETIC_MODULE_FIRMWARE_LICENSE=Apache-2.0

# not downloaded in a tarball so don't extract
define OPENTRONS_MAGNETIC_MODULE_FIRMWARE_EXTRACT_CMDS
	echo "Nothing to extract"
endef

define OPENTRONS_MAGNETIC_MODULE_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(OPENTRONS_MAGNETIC_MODULE_FIRMWARE_DL_DIR)/$(OPENTRONS_MAGNETIC_MODULE_FIRMWARE_SOURCE) $(TARGET_DIR)/usr/lib/firmware/magnetic-module@$(OPENTRONS_MAGNETIC_MODULE_FIRMWARE_VERSION).hex
endef

$(eval $(generic-package))
