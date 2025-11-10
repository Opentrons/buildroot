################################################################################
#
# python-notebook
#
################################################################################

PYTHON_NOTEBOOK_VERSION = 6.5.7
PYTHON_NOTEBOOK_SOURCE = notebook-$(PYTHON_NOTEBOOK_VERSION).tar.gz
PYTHON_NOTEBOOK_SITE = https://files.pythonhosted.org/packages/05/bc/b025bac523640c13b0c1150466475eac3d79acbf187ef6c1967596c41c43
PYTHON_NOTEBOOK_SETUP_TYPE = pep517
PYTHON_NOTEBOOK_LICENSE = BSD-3-Clause

PYTHON_NOTEBOOK_DEPENDENCIES = host-python-jupyter-packaging \
								python-jinja2 python-tornado \
								python-pyzmq python-ipython-genutils \
								python-traitlets \
								python-jupyter_core \
								python-jupyter_client \
								python-nbformat \
								python-nbconvert \
								python-ipykernel \
								python-send2trash \
								python-terminado \
								python-prometheus_client \
								python-nbclassic

define PYTHON_NOTEBOOK_USERS
	jupyter -1 jupyter -1 * - - -
endef

$(eval $(python-package))
