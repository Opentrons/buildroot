################################################################################
#
# python-shellingham
#
################################################################################

PYTHON_SHELLINGHAM_VERSION = 1.4.0
PYTHON_SHELLINGHAM_SOURCE = shellingham-$(PYTHON_SHELLINGHAM_VERSION).tar.gz
PYTHON_SHELLINGHAM_SITE = https://files.pythonhosted.org/packages/9c/c9/a3e3bc667c8372a74aa4b16649c3466364cd84f7aacb73453c51b0c2c8a7
PYTHON_SHELLINGHAM_SETUP_TYPE = setuptools
PYTHON_SHELLINGHAM_LICENSE = ISC License
PYTHON_SHELLINGHAM_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
