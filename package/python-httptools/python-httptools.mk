################################################################################
#
# python-httptools
#
################################################################################

PYTHON_HTTPTOOLS_VERSION = 0.6.0
PYTHON_HTTPTOOLS_SOURCE = httptools-$(PYTHON_HTTPTOOLS_VERSION).tar.gz
PYTHON_HTTPTOOLS_SITE = https://files.pythonhosted.org/packages/e3/3f/e976f6cf3da5e9dbda0096a0e65c1b109036a562658e020971ec54d007fb
PYTHON_HTTPTOOLS_SETUP_TYPE = setuptools
PYTHON_HTTPTOOLS_LICENSE = MIT
PYTHON_HTTPTOOLS_LICENSE_FILES = LICENSE

$(eval $(python-package))
