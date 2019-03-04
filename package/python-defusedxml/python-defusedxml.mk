################################################################################
#
# python-defusedxml
#
################################################################################

PYTHON_DEFUSEDXML_VERSION = 0.5.0
PYTHON_DEFUSEDXML_SOURCE = defusedxml-$(PYTHON_DEFUSEDXML_VERSION).tar.gz
PYTHON_DEFUSEDXML_SITE = https://files.pythonhosted.org/packages/74/ba/4ba4e89e21b5a2e267d80736ea674609a0a33cc4435a6d748ef04f1f9374
PYTHON_DEFUSEDXML_SETUP_TYPE = setuptools
PYTHON_DEFUSEDXML_LICENSE = Python Software Foundation License
PYTHON_DEFUSEDXML_LICENSE_FILES = LICENSE

$(eval $(python-package))
