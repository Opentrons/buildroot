################################################################################
#
# python-exceptiongroup
#
################################################################################

PYTHON_EXCEPTIONGROUP_VERSION = 1.2.0
PYTHON_EXCEPTIONGROUP_SOURCE = exceptiongroup-$(PYTHON_EXCEPTIONGROUP_VERSION).tar.gz
PYTHON_EXCEPTIONGROUP_SITE = https://files.pythonhosted.org/packages/8e/1c/beef724eaf5b01bb44b6338c8c3494eff7cab376fab4904cfbbc3585dc79
PYTHON_EXCEPTIONGROUP_SETUP_TYPE = setuptools
PYTHON_EXCEPTIONGROUP_LICENSE = MIT
PYTHON_EXCEPTIONGROUP_LICENSE_FILES = LICENSE.txt

PYTHON_EXCEPTIONGROUP_DEPENDENCIES = python-traitlets

$(eval $(python-package))
