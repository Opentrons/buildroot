################################################################################
#
# python-python_version
#
################################################################################

PYTHON_PYTHON_VERSION_VERSION = 0.0.2
PYTHON_PYTHON_VERSION_SOURCE = python_version-$(PYTHON_PYTHON_VERSION_VERSION).tar.gz
PYTHON_PYTHON_VERSION_SITE = https://files.pythonhosted.org/packages/fe/74/8ed1d7f895b33a89565be4b1c8651d503fcb2cdda951fef4ec6f6906432c
PYTHON_PYTHON_VERSION_SETUP_TYPE = pep517
PYTHON_PYTHON_VERSION_LICENSE = PUBLICDOMAIN
PYTHON_PYTHON_VERSION_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
