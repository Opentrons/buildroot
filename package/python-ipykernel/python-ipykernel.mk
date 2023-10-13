################################################################################
#
# python-ipykernel
#
################################################################################

PYTHON_IPYKERNEL_VERSION = 6.25.2
PYTHON_IPYKERNEL_SOURCE = ipykernel-$(PYTHON_IPYKERNEL_VERSION).tar.gz
PYTHON_IPYKERNEL_SITE = https://files.pythonhosted.org/packages/8b/4a/3c1ba010e1517191eefb9f2fc556a3aed146b8c4e65708aed3ad17e803c5
PYTHON_IPYKERNEL_SETUP_TYPE = setuptools
PYTHON_IPYKERNEL_LICENSE = BSD-3-Clause
PYTHON_IPYKERNEL_DEPENDENCIES = python-ipython python-jupyter_client host-python-ipython host-python-jupyter_client python-stack-data host-python-backcall

$(eval $(python-package))
