################################################################################
#
# python-notebook
#
################################################################################

PYTHON_NOTEBOOK_VERSION = 6.0.3
PYTHON_NOTEBOOK_SOURCE = notebook-$(PYTHON_NOTEBOOK_VERSION).tar.gz
PYTHON_NOTEBOOK_SITE = https://files.pythonhosted.org/packages/a9/c8/77ab314f1a0102c50762efcc2b58be99780ddffb88bcd5820e2715e1799e
PYTHON_NOTEBOOK_SETUP_TYPE = setuptools
PYTHON_NOTEBOOK_LICENSE = BSD-3-Clause

PYTHON_NOTEBOOK_DEPENDENCIES = python-setuptools python-jinja2 python-tornado python-pyzmq python-ipython-genutils python-traitlets python-jupyter_core python-jupyter_client python-nbformat python-nbconvert python-ipykernel python-send2trash python-terminado python-prometheus_client

define PYTHON_NOTEBOOK_USERS
	jupyter -1 jupyter -1 * - - -
endef

$(eval $(python-package))
