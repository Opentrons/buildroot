################################################################################
#
# python-apply_defaults
#
################################################################################

PYTHON_APPLY_DEFAULTS_VERSION = 0.1.1
PYTHON_APPLY_DEFAULTS_SOURCE = apply_defaults-$(PYTHON_APPLY_DEFAULTS_VERSION).tar.gz
PYTHON_APPLY_DEFAULTS_SITE = https://files.pythonhosted.org/packages/6f/a1/059eaf24fe528b68df5ccd2014e36241bf92261bd85f8e4d11721b9227b4
PYTHON_APPLY_DEFAULTS_SETUP_TYPE = setuptools
PYTHON_APPLY_DEFAULTS_LICENSE = None 

$(eval $(python-package))
