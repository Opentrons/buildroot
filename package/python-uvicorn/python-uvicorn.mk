################################################################################
#
# python-uvicorn
#
################################################################################

PYTHON_UVICORN_VERSION = 0.14.0
PYTHON_UVICORN_SOURCE = uvicorn-$(PYTHON_UVICORN_VERSION).tar.gz
PYTHON_UVICORN_SITE = https://files.pythonhosted.org/packages/e9/9e/25d59f5043cf763833b2581c8027fa92342c4cf8ee523b498ecdf460c16d
PYTHON_UVICORN_SETUP_TYPE = setuptools

$(eval $(python-package))
