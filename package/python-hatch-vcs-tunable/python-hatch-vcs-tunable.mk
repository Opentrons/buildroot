################################################################################
#
# python-hatch-vcs-tunable
#
################################################################################

PYTHON_HATCH_VCS_TUNABLE_VERSION = 0.0.1a3
PYTHON_HATCH_VCS_TUNABLE_SOURCE = hatch_vcs_tunable-$(PYTHON_HATCH_VCS_TUNABLE_VERSION).tar.gz
PYTHON_HATCH_VCS_TUNABLE_SITE = https://files.pythonhosted.org/packages/9d/b4/c9a31f79b58ee2e503dc56e7d8196af544c5d0fe227b08e1988291fe5a62
PYTHON_HATCH_VCS_TUNABLE_LICENSE = Apache-2
PYTHON_HATCH_VCS_TUNABLE_LICENSE_FILES = LICENSE
PYTHON_HATCH_VCS_TUNABLE_SETUP_TYPE = hatch
HOST_PYTHON_HATCH_VCS_TUNABLE_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-vcs

$(eval $(host-python-hatch-package))
