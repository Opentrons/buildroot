################################################################################
#
# python-dotenv
#
################################################################################

PYTHON_DOTENV_VERSION = 0.12.0
PYTHON_DOTENV_SOURCE = python-dotenv-$(PYTHON_DOTENV_VERSION).tar.gz
PYTHON_DOTENV_SITE = https://files.pythonhosted.org/packages/81/8b/26f807fa58582455f8ebb07f1b7473ee1a21b4671d1eaf4fecece9337e2a
PYTHON_DOTENV_SETUP_TYPE = setuptools
PYTHON_DOTENV_LICENSE = LICENSE.txt
PYTHON_DOTENV_LICENSE_FILES = LICENSE

$(eval $(python-package))
