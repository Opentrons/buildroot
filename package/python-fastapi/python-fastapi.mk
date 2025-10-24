################################################################################
#
# python-fastapi
#
################################################################################

PYTHON_FASTAPI_VERSION = 0.100.0
PYTHON_FASTAPI_SOURCE = fastapi-$(PYTHON_FASTAPI_VERSION).tar.gz
PYTHON_FASTAPI_SITE = https://files.pythonhosted.org/packages/65/e0/f9d77b3a1569e2217abf260b0b1462401736973d1c5d3d335f6f2009daa2
PYTHON_FASTAPI_SETUP_TYPE = hatch
PYTHON_FASTAPI_LICENSE = MIT
PYTHON_FASTAPI_LICENSE_FILES = LICENSE
PYTHON_FASTAPI_DEPENDENCIES = host-python-hatchling

$(eval $(python-hatch-package))
