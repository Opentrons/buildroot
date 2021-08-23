################################################################################
#
# python-sniffio
#
################################################################################

PYTHON_SNIFFIO_VERSION = 1.2.0
PYTHON_SNIFFIO_SOURCE = sniffio-$(PYTHON_SNIFFIO_VERSION).tar.gz
PYTHON_SNIFFIO_SITE = https://files.pythonhosted.org/packages/a6/ae/44ed7978bcb1f6337a3e2bef19c941de750d73243fc9389140d62853b686
PYTHON_SNIFFIO_SETUP_TYPE = setuptools
PYTHON_SNIFFIO_LICENSE = Apache-2.0
PYTHON_SNIFFIO_LICENSE_FILES = LICENSE

$(eval $(python-package))
