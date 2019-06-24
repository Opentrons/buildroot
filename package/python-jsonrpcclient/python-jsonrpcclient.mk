################################################################################
#
# python-jsonrpcclient
#
################################################################################

PYTHON_JSONRPCCLIENT_VERSION = 3.3.2
PYTHON_JSONRPCCLIENT_SOURCE = jsonrpcclient-$(PYTHON_JSONRPCCLIENT_VERSION).tar.gz
PYTHON_JSONRPCCLIENT_SITE = https://files.pythonhosted.org/packages/25/ea/dfbe55b07f01b99e16691a8d02107b52e55cf68afd7f0a56adc089b9b799
PYTHON_JSONRPCCLIENT_SETUP_TYPE = setuptools
PYTHON_JSONRPCCLIENT_LICENSE = MIT

$(eval $(python-package))
