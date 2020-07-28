################################################################################
#
# python-wsproto
#
################################################################################

PYTHON_WSPROTO_VERSION = 0.15.0
PYTHON_WSPROTO_SOURCE = wsproto-$(PYTHON_WSPROTO_VERSION).tar.gz
PYTHON_WSPROTO_SITE = https://files.pythonhosted.org/packages/7b/5c/7b125c14fbdbeb7913d61e5841e20a453d71d5a5d961354a384c3ceeb81c
PYTHON_WSPROTO_SETUP_TYPE = setuptools
PYTHON_WSPROTO_LICENSE = MIT
PYTHON_WSPROTO_LICENSE_FILES = LICENSE

$(eval $(python-package))
