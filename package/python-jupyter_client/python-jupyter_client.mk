################################################################################
#
# python-jupyter_client
#
################################################################################

PYTHON_JUPYTER_CLIENT_VERSION = 5.2.4
PYTHON_JUPYTER_CLIENT_SOURCE = jupyter_client-$(PYTHON_JUPYTER_CLIENT_VERSION).tar.gz
PYTHON_JUPYTER_CLIENT_SITE = https://files.pythonhosted.org/packages/e5/5c/f9b2182a445e3a6a8204daf04193154c474220f836dbcedc7d139276600e
PYTHON_JUPYTER_CLIENT_SETUP_TYPE = setuptools
PYTHON_JUPYTER_CLIENT_LICENSE = BSD-3-Clause

PYTHON_JUPYTER_CLIENT_DEPENDENCIES = python-traitlets python-jupyter_core python-pyzmq python-dateutil python-entrypoints python-tornado

HOST_PYTHON_JUPYTER_CLIENT_INSTALL_OPTS += bdist_egg
PYTHON_JUPYTER_CLIENT_INSTALL_STAGING_OPTS += bdist_egg
PYTHON_JUPYTER_CLIENT_INSTALL_TARGET_OPTS += bdist_egg

HOST_PYTHON_JUPYTER_CLIENT_DEPENDENCIES = host-python-tornado host-python-dateutil host-python-pyzmq host-python-jupyter_core
PYTHON_JUPYTER_CLIENT_DEPENDENCIES = python-tornado python-dateutil python-pyzmq python-jupyter_core

$(eval $(python-package))
$(eval $(host-python-package))
