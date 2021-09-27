################################################################################
#
# python-importlib-resources
#
################################################################################

PYTHON_IMPORTLIB_RESOURCES_VERSION = 5.2.2
PYTHON_IMPORTLIB_RESOURCES_SOURCE = importlib_resources-$(PYTHON_IMPORTLIB_RESOURCES_VERSION).tar.gz
PYTHON_IMPORTLIB_RESOURCES_SITE = https://files.pythonhosted.org/packages/b1/7a/b9e2309e5c619ba3da8806e43bb17873ec6eab22a3d79347778c80563028
PYTHON_IMPORTLIB_RESOURCES_SETUP_TYPE = setuptools
PYTHON_IMPORTLIB_RESOURCES_LICENSE = Apache-2.0
PYTHON_IMPORTLIB_RESOURCES_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
