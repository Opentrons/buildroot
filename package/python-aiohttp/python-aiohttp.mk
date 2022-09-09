################################################################################
#
# python-aiohttp
#
################################################################################

PYTHON_AIOHTTP_VERSION = 3.8.1
PYTHON_AIOHTTP_SOURCE = aiohttp-$(PYTHON_AIOHTTP_VERSION).tar.gz
PYTHON_AIOHTTP_SITE = https://files.pythonhosted.org/packages/5a/86/5f63de7a202550269a617a5d57859a2961f3396ecd1739a70b92224766bc
PYTHON_AIOHTTP_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_LICENSE = Apache-2.0
PYTHON_AIOHTTP_LICENSE_FILES = LICENSE.txt
PYTHON_AIOHTTP_CPE_ID_VENDOR = aiohttp_project
PYTHON_AIOHTTP_CPE_ID_PRODUCT = aiohttp

ifneq ($(BR2_PACKAGE_PYTHON_AIOHTTP_SOURCE),y)
define PYTHON_AIOHTTP_TRIM_SOURCE
   find $(TARGET_DIR)/usr/lib/python*/site-packages/aiohttp/ -name *.c -o -name *.pyx -o -name *.pxd | xargs rm -rf
endef
PYTHON_AIOHTTP_POST_INSTALL_TARGET_HOOKS += PYTHON_AIOHTTP_TRIM_SOURCE
endif


$(eval $(python-package))
