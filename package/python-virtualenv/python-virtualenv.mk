################################################################################
#
# python-virtualenv
#
################################################################################

PYTHON_VIRTUALENV_VERSION = 20.8.1
PYTHON_VIRTUALENV_SOURCE = virtualenv-$(PYTHON_VIRTUALENV_VERSION).tar.gz
PYTHON_VIRTUALENV_SITE = https://files.pythonhosted.org/packages/dd/40/9bc1b32521f78c293c1f8ca423c725737dfa9d09640dbeec61cebca7c5f2
PYTHON_VIRTUALENV_SETUP_TYPE = setuptools
PYTHON_VIRTUALENV_LICENSE = MIT
PYTHON_VIRTUALENV_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
