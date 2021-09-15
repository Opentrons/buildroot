################################################################################
#
# python-fastapi
#
################################################################################

PYTHON_FASTAPI_VERSION = 0.68.1
PYTHON_FASTAPI_SOURCE = fastapi-$(PYTHON_FASTAPI_VERSION).tar.gz
PYTHON_FASTAPI_SITE = https://files.pythonhosted.org/packages/e0/2a/03c3e1ede3aa83c45da1d156b0180288e573f5e2643ec4fd6d697cebebdf
PYTHON_FASTAPI_SETUP_TYPE = distutils
PYTHON_FASTAPI_LICENSE = MIT
PYTHON_FASTAPI_LICENSE_FILES = LICENSE

$(eval $(python-package))
