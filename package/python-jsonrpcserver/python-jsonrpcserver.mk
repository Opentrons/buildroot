################################################################################
#
# python-jsonrpcserver
#
################################################################################

PYTHON_JSONRPCSERVER_VERSION = 4.0.3
PYTHON_JSONRPCSERVER_SOURCE = jsonrpcserver-$(PYTHON_JSONRPCSERVER_VERSION).tar.gz
PYTHON_JSONRPCSERVER_SITE = https://files.pythonhosted.org/packages/7f/05/70e0fd463922ec7f0247339aa5e7d79021101fbe852d784f17af0871d861
PYTHON_JSONRPCSERVER_SETUP_TYPE = setuptools
PYTHON_JSONRPCSERVER_LICENSE = MIT

$(eval $(python-package))
