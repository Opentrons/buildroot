################################################################################
#
# python-oldeset-supported-numpy
#
################################################################################

PYTHON_OLDEST_SUPPORTED_NUMPY_VERSION = 2022.8.16
PYTHON_OLDEST_SUPPORTED_NUMPY_SOURCE = oldest-supported-numpy-$(PYTHON_OLDEST_SUPPORTED_NUMPY_VERSION).tar.gz
PYTHON_OLDEST_SUPPORTED_NUMPY_SITE = https://files.pythonhosted.org/packages/bd/16/5acce594db54b2d499ff151d63a989ac3abae288d414f1948d82f882fe44
PYTHON_OLDEST_SUPPORTED_NUMPY_SETUP_TYPE = pep517
PYTHON_OLDEST_SUPPORTED_NUMPY_LICENSE = BSD
PYTHON_OLDEST_SUPPORTED_NUMPY_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
