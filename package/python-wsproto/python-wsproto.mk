################################################################################
#
# python-wsproto
#
################################################################################

PYTHON_WSPROTO_VERSION = 1.0.0
PYTHON_WSPROTO_SOURCE = wsproto-$(PYTHON_WSPROTO_VERSION).tar.gz
PYTHON_WSPROTO_SITE = https://files.pythonhosted.org/packages/2b/a4/aded0882f8f1cddd68dcd531309a15bf976f301e6a3554055cc06213c227
PYTHON_WSPROTO_SETUP_TYPE = setuptools
PYTHON_WSPROTO_LICENSE = MIT
PYTHON_WSPROTO_LICENSE_FILES = LICENSE

$(eval $(python-package))
