################################################################################
#
# python-fastapi
#
################################################################################

PYTHON_FASTAPI_VERSION = 0.48.0
PYTHON_FASTAPI_SOURCE = fastapi-$(PYTHON_FASTAPI_VERSION).tar.gz
PYTHON_FASTAPI_SITE = https://files.pythonhosted.org/packages/37/d9/679462f5d48458afc8afcc3c8cc62177843aaafb416162666c3fa7b162f3
PYTHON_FASTAPI_SETUP_TYPE = distutils
PYTHON_FASTAPI_LICENSE = MIT
PYTHON_FASTAPI_LICENSE_FILES = LICENSE

$(eval $(python-package))
