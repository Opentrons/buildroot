################################################################################
#
# python-pandas
#
################################################################################

PYTHON_PANDAS_VERSION = 2.0.3
PYTHON_PANDAS_SOURCE = pandas-$(PYTHON_PANDAS_VERSION).tar.gz
PYTHON_PANDAS_SITE = https://files.pythonhosted.org/packages/b1/a7/824332581e258b5aa4f3763ecb2a797e5f9a54269044ba2e50ac19936b32
PYTHON_PANDAS_DEPENDENCIES = python-numpy host-python-numpy host-python-cython host-python-versioneer host-python-numpy
PYTHON_PANDAS_SETUP_TYPE = setuptools
PYTHON_PANDAS_LICENSE = BSD
PYTHON_PANDAS_LICENSE_FILES = LICENSE

ifneq ($(BR2_PACKAGE_PYTHON_PANDAS_TESTS),y)
define PYTHON_PANDAS_REMOVE_TESTS
   rm -rf $(TARGET_DIR)/usr/lib/python*/site-packages/pandas/tests
endef
PYTHON_PANDAS_POST_INSTALL_TARGET_HOOKS += PYTHON_PANDAS_REMOVE_TESTS
endif

PYTHON_PANDAS_ENV=SETUPTOOLS_BUILD_ARGS="--plat-name=linux-armv7l"

$(eval $(python-package))
