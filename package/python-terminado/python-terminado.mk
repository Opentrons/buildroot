################################################################################
#
# python-terminado
#
################################################################################

PYTHON_TERMINADO_VERSION = 0.18.1
PYTHON_TERMINADO_SOURCE = terminado-$(PYTHON_TERMINADO_VERSION).tar.gz
PYTHON_TERMINADO_SITE = https://files.pythonhosted.org/packages/8a/11/965c6fd8e5cc254f1fe142d547387da17a8ebfd75a3455f637c663fb38a0
PYTHON_TERMINADO_SETUP_TYPE = hatch
PYTHON_TERMINADO_LICENSE = BSD-3-Clause
PYTHON_TERMINADO_LICENSE_FILES = LICENSE

$(eval $(python-package))
