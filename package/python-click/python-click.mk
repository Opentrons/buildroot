################################################################################
#
# python-click
#
################################################################################

PYTHON_CLICK_VERSION = 8.0.1
PYTHON_CLICK_SOURCE = click-$(PYTHON_CLICK_VERSION).tar.gz
PYTHON_CLICK_SITE = https://files.pythonhosted.org/packages/21/83/308a74ca1104fe1e3197d31693a7a2db67c2d4e668f20f43a2fca491f9f7
PYTHON_CLICK_SETUP_TYPE = setuptools
PYTHON_CLICK_LICENSE = BSD-3-Clause
PYTHON_CLICK_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))
