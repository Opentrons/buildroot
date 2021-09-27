################################################################################
#
# python-poetry
#
################################################################################

PYTHON_POETRY_VERSION = 1.1.10
PYTHON_POETRY_SOURCE = poetry-$(PYTHON_POETRY_VERSION).tar.gz
PYTHON_POETRY_SITE = https://files.pythonhosted.org/packages/10/04/e89c2691d998955b0c1568be1a034d9568eef700067aa19a28b433ea20f1
PYTHON_POETRY_SETUP_TYPE = setuptools
PYTHON_POETRY_LICENSE = MIT
PYTHON_POETRY_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
