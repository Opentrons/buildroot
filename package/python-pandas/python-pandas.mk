################################################################################
#
# python-pandas
#
################################################################################

PYTHON_PANDAS_VERSION = 1.4.1
PYTHON_PANDAS_SOURCE = pandas-$(PYTHON_PANDAS_VERSION).tar.gz
PYTHON_PANDAS_SITE = https://files.pythonhosted.org/packages/c4/eb/cfa96ba42695b3c28d4864a796d492f188471dd536df7e5e5e0c54b629a6
PYTHON_PANDAS_DEPENDENCIES = host-python-numpy
PYTHON_PANDAS_SETUP_TYPE = setuptools
PYTHON_PANDAS_LICENSE = BSD
PYTHON_PANDAS_LICENSE_FILES = LICENSE

ifneq ($(BR2_PACKAGE_PYTHON_PANDAS_TESTS),y)
define PYTHON_PANDAS_REMOVE_TESTS
   rm -rf $(TARGET_DIR)/usr/lib/python*/site-packages/pandas/tests
   rm -rf $(TARGET_DIR)/usr/lib/python*/site-packasges/pandas/_testing
endef
PYTHON_PANDAS_POST_INSTALL_TARGET_HOOKS += PYTHON_PANDAS_REMOVE_TESTS
endif

$(eval $(python-package))
