################################################################################
#
# python-notebook
#
################################################################################

PYTHON_NOTEBOOK_VERSION = 5.7.4
PYTHON_NOTEBOOK_SOURCE = notebook-$(PYTHON_NOTEBOOK_VERSION).tar.gz
PYTHON_NOTEBOOK_SITE = https://files.pythonhosted.org/packages/6e/22/b5dcce67559d63d0f22e46d806305710808c698a1b91c07eb09e389785e0
PYTHON_NOTEBOOK_SETUP_TYPE = setuptools
PYTHON_NOTEBOOK_LICENSE = BSD-3-Clause

PYTHON_NOTEBOOK_DEPENDENCIES = python-setuptools python-jinja2 python-tornado python-pyzmq python-ipython-genutils python-traitlets python-jupyter_core python-jupyter_client python-nbformat python-nbconvert python-ipykernel python-send2trash python-terminado python-prometheus_client

define PYTHON_NOTEBOOK_USERS
	jupyter -1 jupyter -1 * - - -
endef

$(eval $(python-package))
