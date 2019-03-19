################################################################################
#
# python-prometheus_client
#
################################################################################

PYTHON_PROMETHEUS_CLIENT_VERSION = 0.6.0
PYTHON_PROMETHEUS_CLIENT_SOURCE = prometheus_client-$(PYTHON_PROMETHEUS_CLIENT_VERSION).tar.gz
PYTHON_PROMETHEUS_CLIENT_SITE = https://files.pythonhosted.org/packages/4c/bd/b42db3ec90ffc6be805aad09c1cea4bb13a620d0cd4b21aaa44d13541d71
PYTHON_PROMETHEUS_CLIENT_SETUP_TYPE = setuptools
PYTHON_PROMETHEUS_CLIENT_LICENSE = Apache-2.0

$(eval $(python-package))
