################################################################################
#
# python-pylev
#
################################################################################

PYTHON_PYLEV_VERSION = 1.4.0
PYTHON_PYLEV_SOURCE = pylev-$(PYTHON_PYLEV_VERSION).tar.gz
PYTHON_PYLEV_SITE = https://files.pythonhosted.org/packages/11/f2/404d2bfa30fb4ee7c7a7435d593f9f698b25d191cafec69dd0c726f02f11
PYTHON_PYLEV_SETUP_TYPE = setuptools
PYTHON_PYLEV_LICENSE = BSD-3-Clause
PYTHON_PYLEV_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
