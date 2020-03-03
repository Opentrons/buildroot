################################################################################
#
# python-starlette
#
################################################################################

PYTHON_STARLETTE_VERSION = 0.12.9
PYTHON_STARLETTE_SOURCE = starlette-$(PYTHON_STARLETTE_VERSION).tar.gz
PYTHON_STARLETTE_SITE = https://files.pythonhosted.org/packages/67/95/2220fe5bf287e693a6430d8ee36c681b0157035b7249ec08f8fb36319d16
PYTHON_STARLETTE_SETUP_TYPE = setuptools
PYTHON_STARLETTE_LICENSE = BSD-3-Clause

$(eval $(python-package))
