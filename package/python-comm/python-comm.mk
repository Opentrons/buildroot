################################################################################
#
# python-comm
#
################################################################################

PYTHON_COMM_VERSION = 0.1.4
PYTHON_COMM_SOURCE = comm-$(PYTHON_COMM_VERSION).tar.gz
PYTHON_COMM_SITE = https://files.pythonhosted.org/packages/6c/c1/839b14561c958d42a875851fcdf4c15604ba8fd174d22f9003eb97d0611e
PYTHON_COMM_SETUP_TYPE = setuptools
PYTHON_COMM_LICENSE = MIT
PYTHON_COMM_LICENSE_FILES = LICENSE.txt

PYTHON_COMM_DEPENDENCIES = python-traitlets

$(eval $(python-package))
