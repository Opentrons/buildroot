################################################################################
#
# python-fastjsonschema
#
################################################################################

PYTHON_FASTJSONSCHEMA_VERSION = 2.19.1
PYTHON_FASTJSONSCHEMA_SOURCE = fastjsonschema-$(PYTHON_FASTJSONSCHEMA_VERSION).tar.gz
PYTHON_FASTJSONSCHEMA_SITE = https://files.pythonhosted.org/packages/ba/7f/cedf77ace50aa60c566deaca9066750f06e1fcf6ad24f254d255bb976dd6
PYTHON_FASTJSONSCHEMA_SETUP_TYPE = setuptools
PYTHON_FASTJSONSCHEMA_LICENSE = BSD
PYTHON_FASTJSONSCHEMA_LICENSE_FILES = LICENSE

$(eval $(python-package))
