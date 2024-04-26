################################################################################
#
# python-filetype
#
################################################################################

PYTHON_FILETYPE_VERSION = 1.2.0
PYTHON_FILETYPE_SOURCE = filetype-$(PYTHON_FILETYPE_VERSION).tar.gz
PYTHON_FILETYPE_SITE = https://files.pythonhosted.org/packages/bb/29/745f7d30d47fe0f251d3ad3dc2978a23141917661998763bebb6da007eb1
PYTHON_FILETYPE_SETUP_TYPE = pep517
PYTHON_FILETYPE_LICENSE = MIT
PYTHON_FILETYPE_LICENSE_FILES = LICENSE

$(eval $(python-package))
