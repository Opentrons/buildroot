################################################################################
#
# python-h11
#
################################################################################

PYTHON_H11_VERSION = 0.12.0
PYTHON_H11_SOURCE = h11-$(PYTHON_H11_VERSION).tar.gz
PYTHON_H11_SITE = https://files.pythonhosted.org/packages/bd/e9/72c3dc8f7dd7874812be6a6ec788ba1300bfe31570963a7e788c86280cb9
PYTHON_H11_SETUP_TYPE = setuptools
PYTHON_H11_LICENSE = MIT
PYTHON_H11_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
