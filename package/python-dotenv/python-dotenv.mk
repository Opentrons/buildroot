################################################################################
#
# python-dotenv
#
################################################################################

PYTHON_DOTENV_VERSION = 0.19.0
PYTHON_DOTENV_SOURCE = python-dotenv-$(PYTHON_DOTENV_VERSION).tar.gz
PYTHON_DOTENV_SITE = https://files.pythonhosted.org/packages/59/39/20eb771fc2113fb67638d4f2e1905c51b0c75862d09018a393470234a51c
PYTHON_DOTENV_SETUP_TYPE = setuptools
PYTHON_DOTENV_LICENSE = BSD-3-Clause
PYTHON_DOTENV_LICENSE_FILES = LICENSE

$(eval $(python-package))
