################################################################################
#
# python-tzdata
#
################################################################################

PYTHON_TZDATA_VERSION = 2023.4
PYTHON_TZDATA_SOURCE = tzdata-$(PYTHON_TZDATA_VERSION).tar.gz
PYTHON_TZDATA_SITE = https://files.pythonhosted.org/packages/4d/60/acd18ca928cc20eace3497b616b6adb8ce1abc810dd4b1a22bc6bdefac92
PYTHON_TZDATA_SETUP_TYPE = setuptools
PYTHON_TZDATA_LICENSE = APACHE
PYTHON_TZDATA_LICENSE_FILES = LICENSE



$(eval $(python-package))
