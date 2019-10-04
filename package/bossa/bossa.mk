################################################################################
#
# bossa
#
################################################################################

BOSSA_VERSION = 8202074d53ba666a7bbe9def780a9a9f78a4b140
BOSSA_SITE = $(call github,shumatech,BOSSA,$(BOSSA_VERSION))
BOSSA_LICENSE = BSD-3-Clause
BOSSA_LICENSE_FILES = BOSSA/LICENSE

define BOSSA_BUILD_CMDS
	$(MAKE)	$(TARGET_CONFIGURE_OPTS) -C $(@D)	bossac
endef

define BOSSA_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(BUILD_DIR)/bossa-$(BOSSA_VERSION)/bin/bossac $(TARGET_DIR)/usr/bin/bossac
endef

$(eval $(generic-package))
