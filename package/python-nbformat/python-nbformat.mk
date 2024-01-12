################################################################################
#
# python-nbformat
#
################################################################################

PYTHON_NBFORMAT_VERSION = 5.9.2
PYTHON_NBFORMAT_SOURCE = nbformat-$(PYTHON_NBFORMAT_VERSION).tar.gz
PYTHON_NBFORMAT_SITE = https://files.pythonhosted.org/packages/54/d8/31dceef56952da6ea2c43405a83c9759a22a86cb530197988cfa8599b178
PYTHON_NBFORMAT_SETUP_TYPE = pep517
PYTHON_NBFORMAT_LICENSE = BSD-3-Clause

PYTHON_NBFORMAT_DEPENDENCIES = host-python-hatchling host-python-hatch-vcs host-python-hatch-nodejs-version
$(eval $(python-package))
