################################################################################
#
# python-pandas
#
################################################################################

PYTHON_PANDAS_VERSION = 2.1.1
PYTHON_PANDAS_SOURCE = pandas-$(PYTHON_PANDAS_VERSION).tar.gz
PYTHON_PANDAS_SITE = https://files.pythonhosted.org/packages/3d/0e/2c225d7a5de6ca0ec7d729aff6ef560544596f3a9bfed77f6dbc1713dbb5
PYTHON_PANDAS_DEPENDENCIES = host-python-numpy host-python-cython host-python-versioneer
PYTHON_PANDAS_SETUP_TYPE = setuptools
PYTHON_PANDAS_LICENSE = BSD
PYTHON_PANDAS_LICENSE_FILES = LICENSE

ifneq ($(BR2_PACKAGE_PYTHON_PANDAS_TESTS),y)
define PYTHON_PANDAS_REMOVE_TESTS
   rm -rf $(TARGET_DIR)/usr/lib/python*/site-packages/pandas/tests
endef
PYTHON_PANDAS_POST_INSTALL_TARGET_HOOKS += PYTHON_PANDAS_REMOVE_TESTS
endif

$(eval $(meson-package))
