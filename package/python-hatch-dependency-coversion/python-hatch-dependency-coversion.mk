################################################################################
#
# python-hatch-dependency-coversion
#
################################################################################

PYTHON_HATCH_DEPENDENCY_COVERSION_VERSION = 0.0.1a3
PYTHON_HATCH_DEPENDENCY_COVERSION_SOURCE = hatch_dependency_coversion-$(PYTHON_HATCH_DEPENDENCY_COVERSION_VERSION).tar.gz
PYTHON_HATCH_DEPENDENCY_COVERSION_SITE = https://files.pythonhosted.org/packages/8f/b3/1a8414e52ff93f5025669dc3eb8efbe371f26072ceaf7fae18cf2f6063c0
PYTHON_HATCH_DEPENDENCY_COVERSION_LICENSE = Apache-2
PYTHON_HATCH_DEPENDENCY_COVERSION_LICENSE_FILES = LICENSE
PYTHON_HATCH_DEPENDENCY_COVERSION_SETUP_TYPE = pep517
HOST_PYTHON_HATCH_DEPENDENCY_COVERSION_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-vcs

$(eval $(host-python-package))
