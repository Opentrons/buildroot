################################################################################
#
# python-tornado
#
################################################################################

PYTHON_TORNADO_VERSION = 6.0.4
PYTHON_TORNADO_SOURCE = tornado-$(PYTHON_TORNADO_VERSION).tar.gz
PYTHON_TORNADO_SITE = https://files.pythonhosted.org/packages/95/84/119a46d494f008969bf0c775cb2c6b3579d3c4cc1bb1b41a022aa93ee242
PYTHON_TORNADO_LICENSE = Apache-2.0
PYTHON_TORNADO_LICENSE_FILES = LICENSE
PYTHON_TORNADO_CPE_ID_VENDOR = tornadoweb
PYTHON_TORNADO_CPE_ID_PRODUCT = tornado
PYTHON_TORNADO_SETUP_TYPE = setuptools

ifneq ($(BR2_PACKAGE_PYTHON_TORNADO_TESTS),y)
define PYTHON_TORNADO_REMOVE_TESTS
   rm -rf $(TARGET_DIR)/usr/lib/python*/site-packages/tornado/test
endef
PYTHON_TORNADO_POST_INSTALL_TARGET_HOOKS += PYTHON_TORNADO_REMOVE_TESTS
endif

$(eval $(python-package))
$(eval $(host-python-package))
