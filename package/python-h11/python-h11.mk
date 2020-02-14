################################################################################
#
# python-h11
#
################################################################################

PYTHON_H11_VERSION = 0.9.0
PYTHON_H11_SOURCE = h11-$(PYTHON_H11_VERSION).tar.gz
PYTHON_H11_SITE = https://files.pythonhosted.org/packages/34/5a/abaa557d20b210117d8c3e6b0b817ce9b329b2e81f87612e60102a924323
PYTHON_H11_SETUP_TYPE = setuptools
PYTHON_H11_LICENSE = MIT
PYTHON_H11_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
