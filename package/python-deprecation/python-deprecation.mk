################################################################################
#
# python-deprecation
#
################################################################################

PYTHON_DEPRECATION_VERSION = 2.1.0
PYTHON_DEPRECATION_SOURCE = deprecation-$(PYTHON_DEPRECATION_VERSION).tar.gz
PYTHON_DEPRECATION_SITE = https://files.pythonhosted.org/packages/5a/d3/8ae2869247df154b64c1884d7346d412fed0c49df84db635aab2d1c40e62
PYTHON_DEPRECATION_SETUP_TYPE = setuptools
PYTHON_DEPRECATION_LICENSE = Apache-2.0
PYTHON_DEPRECATION_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
