################################################################################
#
# opentrons-thermocycler-firmware
#
################################################################################

OPENTRONS_THERMOCYCLER_FIRMWARE_VERSION=v1.1.0
OPENTRONS_THERMOCYCLER_FIRMWARE_SOURCE=thermo-cycler-arduino.ino.bin
OPENTRONS_THERMOCYCLER_FIRMWARE_SITE=https://opentrons-modules-builds.s3.us-east-2.amazonaws.com/thermocycler/$(OPENTRONS_THERMOCYCLER_FIRMWARE_VERSION)
OPENTRONS_THERMOCYCLER_FIRMWARE_LICENSE=Apache-2.0

# not downloaded in a tarball so don't extract
define OPENTRONS_THERMOCYCLER_FIRMWARE_EXTRACT_CMDS
	echo "Nothing to extract"
endef

define OPENTRONS_THERMOCYCLER_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(OPENTRONS_THERMOCYCLER_FIRMWARE_DL_DIR)/$(OPENTRONS_THERMOCYCLER_FIRMWARE_SOURCE) $(TARGET_DIR)/usr/lib/firmware/thermocycler@$(OPENTRONS_THERMOCYCLER_FIRMWARE_VERSION).bin
endef

$(eval $(generic-package))
