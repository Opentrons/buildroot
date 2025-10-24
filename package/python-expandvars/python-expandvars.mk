################################################################################
#
# python-expandvars
#
################################################################################

PYTHON_EXPANDVARS_VERSION = 1.0.0
PYTHON_EXPANDVARS_SOURCE = expandvars-$(PYTHON_EXPANDVARS_VERSION).tar.gz
PYTHON_EXPANDVARS_SITE = https://files.pythonhosted.org/packages/93/a7/997a548c9ed679d7b93c87e091eba591e7cd9fd82ca727136b4b5b9e24cd
PYTHON_EXPANDVARS_SETUP_TYPE = hatch
PYTHON_EXPANDVARS_LICENSE = MIT
PYTHON_EXPANDVARS_LICENSE_FILES = LICENSE

$(eval $(python-hatch-package))
$(eval $(host-python-hatch-package))
