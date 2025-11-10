################################################################################
#
# python-jupyter-packaging
#
################################################################################

PYTHON_JUPYTER_PACKAGING_VERSION = 0.12.3
PYTHON_JUPYTER_PACKAGING_SOURCE = jupyter_packaging-$(PYTHON_JUPYTER_PACKAGING_VERSION).tar.gz
PYTHON_JUPYTER_PACKAGING_SITE = https://files.pythonhosted.org/packages/25/c5/b0e154e6403c6790bb1e66acddf9787296a8196f5b14f4bb9e4c92b6734e
PYTHON_JUPYTER_PACKAGING_SETUP_TYPE = hatch
PYTHON_JUPYTER_PACKAGING_LICENSE = BSD-3-Clause
PYTHON_JUPYTER_PACKAGING_LICENSE_FILES = LICENSE
HOST_PYTHON_JUPYTER_PACKAGING_DEPENDENCIES = host-python-deprecation host-python-packaging host-python-wheel host-python-setuptools host-python-tomlkit host-python-wheel 

$(eval $(host-python-package))
