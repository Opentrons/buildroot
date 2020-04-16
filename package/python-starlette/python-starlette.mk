################################################################################
#
# python-starlette
#
################################################################################

PYTHON_STARLETTE_VERSION = 0.13.2
PYTHON_STARLETTE_SOURCE = starlette-$(PYTHON_STARLETTE_VERSION).tar.gz
PYTHON_STARLETTE_SITE = https://files.pythonhosted.org/packages/8c/2e/78248ccba2102bc1100ed5cad26d91e03806f4f04ff47cccb412d2bb2855
PYTHON_STARLETTE_SETUP_TYPE = setuptools
PYTHON_STARLETTE_LICENSE = BSD-3-Clause

$(eval $(python-package))
