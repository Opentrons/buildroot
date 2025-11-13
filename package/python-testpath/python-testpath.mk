################################################################################
#
# python-testpath
#
################################################################################

PYTHON_TESTPATH_VERSION = 0.6.0
PYTHON_TESTPATH_SOURCE = testpath-$(PYTHON_TESTPATH_VERSION).tar.gz
PYTHON_TESTPATH_SITE = https://files.pythonhosted.org/packages/08/ad/a3e7d580902f57e31d2181563fc4088894692bb6ef79b816344f27719cdc
PYTHON_TESTPATH_SETUP_TYPE = flit
PYTHON_TESTPATH_LICENSE = BSD-3-Clause
PYTHON_TESTPATH_LICENSE_FILES = LICENSE
PYTHON_TESTPATH_DEPENDENCIES += host-python-flit-core host-python-installer

define PYTHON_TESTPATH_REMOVE_EXES
	rm -f $(TARGET_DIR)/usr/lib/python*/site-packages/testpath/*.exe
endef

PYTHON_TESTPATH_POST_INSTALL_TARGET_HOOKS += PYTHON_TESTPATH_REMOVE_EXES

$(eval $(python-package))

