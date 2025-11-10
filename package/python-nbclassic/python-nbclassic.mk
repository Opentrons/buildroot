################################################################################
#
# python-nbclassic
#
################################################################################

PYTHON_NBCLASSIC_VERSION = 0.4.7
PYTHON_NBCLASSIC_SOURCE = nbclassic-$(PYTHON_NBCLASSIC_VERSION).tar.gz
PYTHON_NBCLASSIC_SITE = https://files.pythonhosted.org/packages/ae/5a/6bdc0b20e5f6894fef0be99e0a9132bd8467fd082164fdbdbd37464416f6
PYTHON_NBCLASSIC_SETUP_TYPE = pep517
PYTHON_NBCLASSIC_LICENSE = BSD-3-Clause

PYTHON_NBCLASSIC_DEPENDENCIES = host-python-jupyter-packaging \
								host-python-babel \
								python-jinja2 \
								python-tornado \
								python-pyzmq \
								python-ipython-genutils \
								python-traitlets \
								python-jupyter_core \
								python-jupyter_client \
								python-nbformat \
								python-nbconvert \
								python-ipykernel \
								python-send2trash \
								python-terminado \
								python-prometheus_client

define PYTHON_NBCLASSIC_USERS
	jupyter -1 jupyter -1 * - - -
endef

$(eval $(python-package))
