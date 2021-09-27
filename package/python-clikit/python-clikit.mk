################################################################################
#
# python-clikit
#
################################################################################

PYTHON_CLIKIT_VERSION = 0.6.2
PYTHON_CLIKIT_SOURCE = clikit-$(PYTHON_CLIKIT_VERSION).tar.gz
PYTHON_CLIKIT_SITE = https://files.pythonhosted.org/packages/0b/07/27d700f8447c0ca81454a4acdb7eb200229a6d06fe0b1439acc3da49a53f
PYTHON_CLIKIT_SETUP_TYPE = setuptools
PYTHON_CLIKIT_LICENSE = MIT
PYTHON_CLIKIT_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
