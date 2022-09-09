################################################################################
#
# python-yarl
#
################################################################################

PYTHON_YARL_VERSION = 1.7.2
PYTHON_YARL_SOURCE = yarl-$(PYTHON_YARL_VERSION).tar.gz
PYTHON_YARL_SITE = https://files.pythonhosted.org/packages/f6/da/46d1b3d69a9a0835dabf9d59c7eb0f1600599edd421a4c5a15ab09f527e0
PYTHON_YARL_LICENSE = Apache-2.0
PYTHON_YARL_LICENSE_FILES = LICENSE
PYTHON_YARL_SETUP_TYPE = setuptools

ifneq ($(BR2_PACKAGE_PYTHON_YARL_SOURCE),y)
define PYTHON_YARL_TRIM_SOURCE
   find $(TARGET_DIR)/usr/lib/python*/site-packages/yarl/ -name *.c -o -name *.pyx -o -name *.pxd | xargs rm -rf
endef
PYTHON_YARL_POST_INSTALL_TARGET_HOOKS += PYTHON_YARL_TRIM_SOURCE
endif

$(eval $(python-package))
