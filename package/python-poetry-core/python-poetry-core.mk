################################################################################
#
# python-poetry-core
#
################################################################################

PYTHON_POETRY_CORE_VERSION = 1.0.6
PYTHON_POETRY_CORE_SOURCE = poetry-core-$(PYTHON_POETRY_CORE_VERSION).tar.gz
PYTHON_POETRY_CORE_SITE = https://files.pythonhosted.org/packages/c8/8a/33c9d7cde6fab76b6978d01be4f8e1cfe2c9ad28fa07d1557e32bf6b0755
PYTHON_POETRY_CORE_SETUP_TYPE = setuptools
PYTHON_POETRY_CORE_LICENSE = MIT
PYTHON_POETRY_CORE_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
