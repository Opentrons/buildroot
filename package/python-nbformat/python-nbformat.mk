################################################################################
#
# python-nbformat
#
################################################################################

PYTHON_NBFORMAT_VERSION = 4.4.0
PYTHON_NBFORMAT_SOURCE = nbformat-$(PYTHON_NBFORMAT_VERSION).tar.gz
PYTHON_NBFORMAT_SITE = https://files.pythonhosted.org/packages/6e/0e/160754f7ae3e984863f585a3743b0ed1702043a81245907c8fae2d537155
PYTHON_NBFORMAT_SETUP_TYPE = distutils
PYTHON_NBFORMAT_LICENSE = BSD-3-Clause

$(eval $(python-package))
