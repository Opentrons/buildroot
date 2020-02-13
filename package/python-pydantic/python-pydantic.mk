################################################################################
#
# python-pydantic
#
################################################################################

PYTHON_PYDANTIC_VERSION = 1.4
PYTHON_PYDANTIC_SOURCE = pydantic-$(PYTHON_PYDANTIC_VERSION).tar.gz
PYTHON_PYDANTIC_SITE = https://files.pythonhosted.org/packages/0d/0f/5dd883399fca772c441f4fd8db85320fa7a912fa2f917f0cee1f681f9a93
PYTHON_PYDANTIC_SETUP_TYPE = setuptools
PYTHON_PYDANTIC_LICENSE = MIT
PYTHON_PYDANTIC_LICENSE_FILES = LICENSE

$(eval $(python-package))
