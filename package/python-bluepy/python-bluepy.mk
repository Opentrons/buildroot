################################################################################
#
# python-bluepy
#
################################################################################

PYTHON_BLUEPY_VERSION = 1.3.0
PYTHON_BLUEPY_SOURCE = bluepy-$(PYTHON_BLUEPY_VERSION).tar.gz
PYTHON_BLUEPY_SITE = https://files.pythonhosted.org/packages/27/91/6cfca10bee9862f93015413cf9e6a52c3081a71f1518963396a055128f8e
PYTHON_BLUEPY_SETUP_TYPE = setuptools
PYTHON_BLUEPY_ENV = CC=$(TARGET_CC) LD=$(TARGET_LD)

$(eval $(python-package))
