################################################################################
#
# python-aionotify
#
################################################################################

PYTHON_AIONOTIFY_VERSION = 0.2.0
PYTHON_AIONOTIFY_SOURCE = aionotify-$(PYTHON_AIONOTIFY_VERSION).tar.gz
PYTHON_AIONOTIFY_SITE = https://files.pythonhosted.org/packages/57/c0/237d434870a024a16d89751ec9f4e5340a6d84d49ccb1ab738b3fdee907a
PYTHON_AIONOTIFY_LICENSE = BSD
PYTHON_AIONOTIFY_LICENSE_FILES = LICENSE
PYTHON_AIONOTIFY_SETUP_TYPE = setuptools

$(eval $(python-package))

