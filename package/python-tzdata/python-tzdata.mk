################################################################################
#
# python-tzdata
#
################################################################################

PYTHON_TZDATA_VERSION = 2025.2
PYTHON_TZDATA_SOURCE = tzdata-$(PYTHON_TZDATA_VERSION).tar.gz
PYTHON_TZDATA_SITE = https://files.pythonhosted.org/packages/95/32/1a225d6164441be760d75c2c42e2780dc0873fe382da3e98a2e1e48361e5
PYTHON_TZDATA_SETUP_TYPE = setuptools
PYTHON_TZDATA_LICENSE = Apache-2.0
PYTHON_TZDATA_LICENSE_FILES = LICENSE

$(eval $(python-package))
