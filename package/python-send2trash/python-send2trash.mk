################################################################################
#
# python-send2trash
#
################################################################################

PYTHON_SEND2TRASH_VERSION = 1.5.0
PYTHON_SEND2TRASH_SOURCE = Send2Trash-$(PYTHON_SEND2TRASH_VERSION).tar.gz
PYTHON_SEND2TRASH_SITE = https://files.pythonhosted.org/packages/13/2e/ea40de0304bb1dc4eb309de90aeec39871b9b7c4bd30f1a3cdcb3496f5c0
PYTHON_SEND2TRASH_SETUP_TYPE = setuptools
PYTHON_SEND2TRASH_LICENSE = BSD-3-Clause
PYTHON_SEND2TRASH_LICENSE_FILES = LICENSE

$(eval $(python-package))
