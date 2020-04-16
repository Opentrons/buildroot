################################################################################
#
# python-fastapi
#
################################################################################

PYTHON_FASTAPI_VERSION = 0.54.1
PYTHON_FASTAPI_SOURCE = fastapi-$(PYTHON_FASTAPI_VERSION).tar.gz
PYTHON_FASTAPI_SITE = https://files.pythonhosted.org/packages/4d/54/45770888a4a73666390120b444131568637e70b5e002860bad99fa1dcb27
PYTHON_FASTAPI_SETUP_TYPE = distutils
PYTHON_FASTAPI_LICENSE = MIT
PYTHON_FASTAPI_LICENSE_FILES = LICENSE

$(eval $(python-package))
