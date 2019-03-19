################################################################################
#
# python-testpath
#
################################################################################

PYTHON_TESTPATH_VERSION = 0.4.2
PYTHON_TESTPATH_SOURCE = testpath-$(PYTHON_TESTPATH_VERSION).tar.gz
PYTHON_TESTPATH_SITE = https://files.pythonhosted.org/packages/06/30/9a7e917066d851d8b4117e85794b5f14516419ea714a8a2681ec6aa8a981
PYTHON_TESTPATH_SETUP_TYPE = distutils
PYTHON_TESTPATH_LICENSE = BSD-3-Clause
PYTHON_TESTPATH_LICENSE_FILES = LICENSE

$(eval $(python-package))
