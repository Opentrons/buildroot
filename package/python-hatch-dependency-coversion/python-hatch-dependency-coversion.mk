################################################################################
#
# python-hatch-dependency-coversion
#
################################################################################

PYTHON_HATCH_DEPENDENCY_COVERSION_VERSION = 0.0.1a4
PYTHON_HATCH_DEPENDENCY_COVERSION_SOURCE = hatch_dependency_coversion-$(PYTHON_HATCH_DEPENDENCY_COVERSION_VERSION).tar.gz
PYTHON_HATCH_DEPENDENCY_COVERSION_SITE = https://files.pythonhosted.org/packages/ce/ef/e0b3318483cf797cd25c7bc80eb0852802723ee22631e9897433b25a1209
PYTHON_HATCH_DEPENDENCY_COVERSION_LICENSE = Apache-2
PYTHON_HATCH_DEPENDENCY_COVERSION_LICENSE_FILES = LICENSE
PYTHON_HATCH_DEPENDENCY_COVERSION_SETUP_TYPE = hatch
HOST_PYTHON_HATCH_DEPENDENCY_COVERSION_ENV = HATCH_METADATA_CLASSIFIERS_NO_VERIFY=1
HOST_PYTHON_HATCH_DEPENDENCY_COVERSION_DEPENDENCIES = \
	host-python-hatch-vcs

$(eval $(host-python-package))
