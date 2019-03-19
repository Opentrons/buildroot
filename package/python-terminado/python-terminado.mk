################################################################################
#
# python-terminado
#
################################################################################

PYTHON_TERMINADO_VERSION = 0.8.1
PYTHON_TERMINADO_SOURCE = terminado-$(PYTHON_TERMINADO_VERSION).tar.gz
PYTHON_TERMINADO_SITE = https://files.pythonhosted.org/packages/67/84/ce0ebd0f60e1cbe040f8e065eef7063855d59d9cf5e6438b3f8439fc7e15
PYTHON_TERMINADO_SETUP_TYPE = distutils
PYTHON_TERMINADO_LICENSE = BSD-3-Clause
PYTHON_TERMINADO_LICENSE_FILES = LICENSE

$(eval $(python-package))
