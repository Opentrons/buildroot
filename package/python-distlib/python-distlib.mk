################################################################################
#
# python-distlib
#
################################################################################

PYTHON_DISTLIB_VERSION = 0.3.3
PYTHON_DISTLIB_SOURCE = distlib-$(PYTHON_DISTLIB_VERSION).zip
PYTHON_DISTLIB_SITE = https://files.pythonhosted.org/packages/56/ed/9c876a62efda9901863e2cc8825a13a7fcbda75b4b498103a4286ab1653b
PYTHON_DISTLIB_SETUP_TYPE = distutils
PYTHON_DISTLIB_LICENSE = Python Software Foundation License
PYTHON_DISTLIB_LICENSE_FILES = LICENSE.txt

$(eval $(host-python-package))
