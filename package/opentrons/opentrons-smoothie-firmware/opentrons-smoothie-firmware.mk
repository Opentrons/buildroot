################################################################################
#
# opentrons-smoothie-firmware
#
################################################################################

OPENTRONS_SMOOTHIE_FIRMWARE_VERSION=v1.1.0
OPENTRONS_SMOOTHIE_FIRMWARE_SOURCE=smoothie-$(OPENTRONS_SMOOTHIE_FIRMWARE_VERSION)-25e5cea.hex
OPENTRONS_SMOOTHIE_FIRMWARE_SITE=https://opentrons-smoothieware-hex.s3.us-east-2.amazonaws.com/$(OPENTRONS_SMOOTHIE_FIRMWARE_VERSION)
OPENTRONS_SMOOTHIE_FIRMWARE_LICENSE=GPL-3.0-only

# not downloaded in a tarball so don't extract
define OPENTRONS_SMOOTHIE_FIRMWARE_EXTRACT_CMDS
	echo "Nothing to extract"
endef

define OPENTRONS_SMOOTHIE_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(OPENTRONS_SMOOTHIE_FIRMWARE_DL_DIR)/$(OPENTRONS_SMOOTHIE_FIRMWARE_SOURCE) $(TARGET_DIR)/usr/lib/firmware/$(OPENTRONS_SMOOTHIE_FIRMWARE_SOURCE)
endef

$(eval $(generic-package))
