################################################################################
#
# python-funcsigs
#
################################################################################

PYTHON_FUNCSIGS_VERSION = 1.0.2
PYTHON_FUNCSIGS_SOURCE = funcsigs-$(PYTHON_FUNCSIGS_VERSION).tar.gz
PYTHON_FUNCSIGS_SITE = https://files.pythonhosted.org/packages/94/4a/db842e7a0545de1cdb0439bb80e6e42dfe82aaeaadd4072f2263a4fbed23
PYTHON_FUNCSIGS_SETUP_TYPE = setuptools
PYTHON_FUNCSIGS_LICENSE = Apache-2.0
PYTHON_FUNCSIGS_LICENSE_FILES = LICENSE

$(eval $(python-package))
