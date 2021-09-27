################################################################################
#
# python-platformdirs
#
################################################################################

PYTHON_PLATFORMDIRS_VERSION = 2.4.0
PYTHON_PLATFORMDIRS_SOURCE = platformdirs-$(PYTHON_PLATFORMDIRS_VERSION).tar.gz
PYTHON_PLATFORMDIRS_SITE = https://files.pythonhosted.org/packages/4b/96/d70b9462671fbeaacba4639ff866fb4e9e558580853fc5d6e698d0371ad4
PYTHON_PLATFORMDIRS_SETUP_TYPE = setuptools
PYTHON_PLATFORMDIRS_LICENSE = MIT
PYTHON_PLATFORMDIRS_LICENSE_FILES = LICENSE.txt

$(eval $(host-python-package))
