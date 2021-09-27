################################################################################
#
# python-cachy
#
################################################################################

PYTHON_CACHY_VERSION = 0.3.0
PYTHON_CACHY_SOURCE = cachy-$(PYTHON_CACHY_VERSION).tar.gz
PYTHON_CACHY_SITE = https://files.pythonhosted.org/packages/a0/0c/45b249b0efce50a430b8810ec34c5f338d853c31c24b0b297597fd28edda
PYTHON_CACHY_SETUP_TYPE = distutils
PYTHON_CACHY_LICENSE = MIT
PYTHON_CACHY_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
