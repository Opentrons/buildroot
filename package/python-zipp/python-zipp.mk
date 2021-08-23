################################################################################
#
# python-zipp
#
################################################################################

PYTHON_ZIPP_VERSION = 3.5.0
PYTHON_ZIPP_SOURCE = zipp-$(PYTHON_ZIPP_VERSION).tar.gz
PYTHON_ZIPP_SITE = https://files.pythonhosted.org/packages/3a/9f/1d4b62cbe8d222539a84089eeab603d8e45ee1f897803a0ae0860400d6e7
PYTHON_ZIPP_SETUP_TYPE = setuptools
PYTHON_ZIPP_LICENSE = MIT
PYTHON_ZIPP_LICENSE_FILES = LICENSE
PYTHON_ZIPP_DEPENDENCIES = host-python-setuptools-scm host-python-toml

$(eval $(python-package))
