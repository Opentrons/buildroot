################################################################################
#
# python-tomlkit
#
################################################################################

PYTHON_TOMLKIT_VERSION = 0.7.2
PYTHON_TOMLKIT_SOURCE = tomlkit-$(PYTHON_TOMLKIT_VERSION).tar.gz
PYTHON_TOMLKIT_SITE = https://files.pythonhosted.org/packages/65/ed/7b7216101bc48627b630693b03392f33827901b81d4e1360a76515e3abc4
PYTHON_TOMLKIT_SETUP_TYPE = setuptools
PYTHON_TOMLKIT_LICENSE = MIT
PYTHON_TOMLKIT_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
