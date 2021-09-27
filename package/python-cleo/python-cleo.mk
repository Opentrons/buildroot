################################################################################
#
# python-cleo
#
################################################################################

PYTHON_CLEO_VERSION = 0.8.1
PYTHON_CLEO_SOURCE = cleo-$(PYTHON_CLEO_VERSION).tar.gz
PYTHON_CLEO_SITE = https://files.pythonhosted.org/packages/a5/36/943c12bc9b56f5fc83661558c576a3d95df0d0f9c153f87ee4c19647025b
PYTHON_CLEO_SETUP_TYPE = setuptools
PYTHON_CLEO_LICENSE = MIT
PYTHON_CLEO_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
