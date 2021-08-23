################################################################################
#
# python-anyio
#
################################################################################

PYTHON_ANYIO_VERSION = 3.3.0
PYTHON_ANYIO_SOURCE = anyio-$(PYTHON_ANYIO_VERSION).tar.gz
PYTHON_ANYIO_SITE = https://files.pythonhosted.org/packages/58/92/29df8cc2d38a54c1db0074bc745109b30edbcccf3ebac7c3c82c63cd692c
PYTHON_ANYIO_SETUP_TYPE = setuptools
PYTHON_ANYIO_LICENSE = MIT
PYTHON_ANYIO_LICENSE_FILES = LICENSE
PYTHON_ANYIO_DEPENDENCIES = host-python-setuptools-scm host-python-toml

$(eval $(python-package))
