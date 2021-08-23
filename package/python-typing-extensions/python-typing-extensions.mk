################################################################################
#
# python-typing-extensions
#
################################################################################

PYTHON_TYPING_EXTENSIONS_VERSION = 3.10.0.0
PYTHON_TYPING_EXTENSIONS_SOURCE = typing_extensions-$(PYTHON_TYPING_EXTENSIONS_VERSION).tar.gz
PYTHON_TYPING_EXTENSIONS_SITE = https://files.pythonhosted.org/packages/aa/55/62e2d4934c282a60b4243a950c9dbfa01ae7cac0e8d6c0b5315b87432c81
PYTHON_TYPING_EXTENSIONS_SETUP_TYPE = setuptools
PYTHON_TYPING_EXTENSIONS_LICENSE = PSF-2.0
PYTHON_TYPING_EXTENSIONS_LICENSE_FILES = LICENSE

$(eval $(python-package))
