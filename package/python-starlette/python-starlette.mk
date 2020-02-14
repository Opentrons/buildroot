################################################################################
#
# python-starlette
#
################################################################################

PYTHON_STARLETTE_VERSION = 0.13.1
PYTHON_STARLETTE_SOURCE = starlette-$(PYTHON_STARLETTE_VERSION).tar.gz
PYTHON_STARLETTE_SITE = https://files.pythonhosted.org/packages/2c/e4/244978c726428c440a333d0cbf68913eb0816a565822fdce3075d1c729f1
PYTHON_STARLETTE_SETUP_TYPE = setuptools
PYTHON_STARLETTE_LICENSE = BSD-3-Clause

$(eval $(python-package))
