################################################################################
#
# python-jupyter_client
#
################################################################################

PYTHON_JUPYTER_CLIENT_VERSION = 6.1.12
PYTHON_JUPYTER_CLIENT_SOURCE = jupyter_client-$(PYTHON_JUPYTER_CLIENT_VERSION).tar.gz
PYTHON_JUPYTER_CLIENT_SITE = https://files.pythonhosted.org/packages/de/05/6b1809dbe46e21c4018721c14a989a150ff73b4ecf631fe6e22d02cac579
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
