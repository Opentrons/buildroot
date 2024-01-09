################################################################################
#
# python-nest-asyncio
#
################################################################################

PYTHON_NEST_ASYNCIO_VERSION = 1.5.8
PYTHON_NEST_ASYNCIO_SOURCE = nest_asyncio-$(PYTHON_NEST_ASYNCIO_VERSION).tar.gz
PYTHON_NEST_ASYNCIO_SITE = https://files.pythonhosted.org/packages/93/fd/4c3fa3f390d00f4c85d1102988d3fda588e8d45216998715bfa2f5caf411
PYTHON_NEST_ASYNCIO_SETUP_TYPE = setuptools
PYTHON_NEST_ASYNCIO_LICENSE = BSD-2-Clause
PYTHON_NEST_ASYNCIO_LICENSE_FILES = LICENSE

$(eval $(python-package))
