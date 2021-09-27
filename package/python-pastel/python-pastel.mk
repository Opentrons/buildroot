################################################################################
#
# python-pastel
#
################################################################################

PYTHON_PASTEL_VERSION = 0.2.1
PYTHON_PASTEL_SOURCE = pastel-$(PYTHON_PASTEL_VERSION).tar.gz
PYTHON_PASTEL_SITE = https://files.pythonhosted.org/packages/76/f1/4594f5e0fcddb6953e5b8fe00da8c317b8b41b547e2b3ae2da7512943c62
PYTHON_PASTEL_SETUP_TYPE = setuptools
PYTHON_PASTEL_LICENSE = MIT
PYTHON_PASTEL_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
