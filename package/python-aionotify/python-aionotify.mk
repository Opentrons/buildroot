################################################################################
#
# python-aionotify
#
################################################################################

PYTHON_AIONOTIFY_VERSION = 0.3.1
PYTHON_AIONOTIFY_SOURCE = aionotify-$(PYTHON_AIONOTIFY_VERSION).tar.gz
PYTHON_AIONOTIFY_SITE = https://files.pythonhosted.org/packages/23/16/81a26a64d728e76eea073cd0316f3e8885cca312247a9ba9af64d7c47e64
PYTHON_AIONOTIFY_LICENSE = BSD
PYTHON_AIONOTIFY_LICENSE_FILES = LICENSE
PYTHON_AIONOTIFY_SETUP_TYPE = setuptools

$(eval $(python-package))

