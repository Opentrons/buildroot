################################################################################
#
# python-ipykernel
#
################################################################################

PYTHON_IPYKERNEL_VERSION = 5.1.0
PYTHON_IPYKERNEL_SOURCE = ipykernel-$(PYTHON_IPYKERNEL_VERSION).tar.gz
PYTHON_IPYKERNEL_SITE = https://files.pythonhosted.org/packages/11/0b/95330660f8cc5d63428b9886c800ea8d68842fd866389cf579acca4915be
PYTHON_IPYKERNEL_SETUP_TYPE = setuptools
PYTHON_IPYKERNEL_LICENSE = BSD-3-Clause
PYTHON_IPYKERNEL_DEPENDENCIES = python-ipython python-jupyter_client host-python-ipython host-python-jupyter_client

$(eval $(python-package))
