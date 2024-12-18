################################################################################
#
# python-pydantic-settings
#
################################################################################

PYTHON_PYDANTIC_SETTINGS_VERSION = 2.4.0
PYTHON_PYDANTIC_SETTINGS_SOURCE = pydantic_settings-$(PYTHON_PYDANTIC_SETTINGS_VERSION).tar.gz
PYTHON_PYDANTIC_SETTINGS_SITE = https://files.pythonhosted.org/packages/58/14/7bfb313ccee79f97dc235721b035174af94ef4472cfe455c259cd2971f2f
PYTHON_PYDANTIC_SETTINGS_SETUP_TYPE = pep517
PYTHON_PYDANTIC_SETTINGS_LICENSE = MIT
PYTHON_PYDANTIC_SETTINGS_LICENSE_FILES = LICENSE
PYTHON_PYDANTIC_SETTINGS_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
