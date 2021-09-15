################################################################################
#
# python-starlette
#
################################################################################

PYTHON_STARLETTE_VERSION = 0.14.2
PYTHON_STARLETTE_SOURCE = starlette-$(PYTHON_STARLETTE_VERSION).tar.gz
PYTHON_STARLETTE_SITE = https://files.pythonhosted.org/packages/3a/06/ded663a1ddea8b11a2027d88ff0e757f9cdb812310f18bee33ef7270112f
PYTHON_STARLETTE_SETUP_TYPE = setuptools
PYTHON_STARLETTE_LICENSE = BSD-3-Clause
PYTHON_STARLETTE_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
