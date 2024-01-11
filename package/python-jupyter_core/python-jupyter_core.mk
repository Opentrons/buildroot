################################################################################
#
# python-jupyter_core
#
################################################################################

PYTHON_JUPYTER_CORE_VERSION = 4.6.1
PYTHON_JUPYTER_CORE_SOURCE = jupyter_core-$(PYTHON_JUPYTER_CORE_VERSION).tar.gz
PYTHON_JUPYTER_CORE_SITE = https://files.pythonhosted.org/packages/f4/86/b1d5b38cfb9b0c747bda6e1ee330b800b895de755b14304b5cb12d925cd7
PYTHON_JUPYTER_CORE_SETUP_TYPE = setuptools
PYTHON_JUPYTER_CORE_LICENSE = BSD-3-Clause

$(eval $(python-package))
$(eval $(host-python-package))
