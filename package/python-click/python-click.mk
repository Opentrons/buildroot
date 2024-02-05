################################################################################
#
# python-click
#
################################################################################

PYTHON_CLICK_VERSION = 8.1.2
PYTHON_CLICK_SOURCE = click-$(PYTHON_CLICK_VERSION).tar.gz
PYTHON_CLICK_SITE = https://files.pythonhosted.org/packages/42/e1/4cb2d3a2416bcd871ac93f12b5616f7755a6800bccae05e5a99d3673eb69
PYTHON_CLICK_SETUP_TYPE = setuptools
PYTHON_CLICK_LICENSE = BSD-3-Clause
PYTHON_CLICK_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))
