################################################################################
#
# python-ipykernel
#
################################################################################

PYTHON_IPYKERNEL_VERSION = 6.20.2
PYTHON_IPYKERNEL_SOURCE = ipykernel-$(PYTHON_IPYKERNEL_VERSION).tar.gz
PYTHON_IPYKERNEL_SITE = https://files.pythonhosted.org/packages/87/c0/16e5656247203e7ae67e528f580561c9b54166145c10b46e3ad117984902
PYTHON_IPYKERNEL_SETUP_TYPE = pep517
PYTHON_IPYKERNEL_LICENSE = BSD-3-Clause
PYTHON_IPYKERNEL_DEPENDENCIES = python-comm python-debugpy python-ipython python-jupyter_client host-python-ipython host-python-jupyter_client python-stack-data host-python-backcall host-python-hatchling host-python-hatch-vcs

$(eval $(python-package))
