################################################################################
#
# python-importlib-metadata
#
################################################################################

PYTHON_IMPORTLIB_METADATA_VERSION = 4.8.1
PYTHON_IMPORTLIB_METADATA_SOURCE = importlib_metadata-$(PYTHON_IMPORTLIB_METADATA_VERSION).tar.gz
PYTHON_IMPORTLIB_METADATA_SITE = https://files.pythonhosted.org/packages/f0/70/ca3dd67cdd368b957e73a8156f7e1a10339f9813e314cb8b4549526070da
PYTHON_IMPORTLIB_METADATA_SETUP_TYPE = setuptools
PYTHON_IMPORTLIB_METADATA_LICENSE = Apache-2.0
PYTHON_IMPORTLIB_METADATA_LICENSE_FILES = LICENSE
PYTHON_IMPORTLIB_METADATA_DEPENDENCIES = host-python-setuptools-scm host-python-toml

$(eval $(python-package))
$(eval $(host-python-package))
