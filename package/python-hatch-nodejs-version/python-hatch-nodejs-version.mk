################################################################################
#
# python-hatch-nodejs-version
#
################################################################################

PYTHON_HATCH_NODEJS_VERSION_VERSION = 0.3.2
PYTHON_HATCH_NODEJS_VERSION_SOURCE = hatch_nodejs_version-$(PYTHON_HATCH_NODEJS_VERSION_VERSION).tar.gz
PYTHON_HATCH_NODEJS_VERSION_SITE = https://files.pythonhosted.org/packages/af/b6/c9406cfa9edf740c6b3de6173408a159228eac0cee80eead4a5b9cc88848
PYTHON_HATCH_NODEJS_VERSION_SETUP_TYPE = pep517
PYTHON_HATCH_NODEJS_VERSION_LICENSE = BSD-3-Clause

PYTHON_HATCH_NODEJS_VERSION_DEPENDENCIES = host-python-hatchling host-python-hatch-vcs
$(eval $(host-python-package))
