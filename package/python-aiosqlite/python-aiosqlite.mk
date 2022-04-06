################################################################################
#
# python-aiosqlite
#
################################################################################

PYTHON_AIOSQLITE_VERSION = 0.17.0
PYTHON_AIOSQLITE_SOURCE = aiosqlite-$(PYTHON_AIOSQLITE_VERSION).tar.gz
PYTHON_AIOSQLITE_SITE = https://files.pythonhosted.org/packages/40/e0/ad1edd74311831ca71b32a5b83352b490d78d11a90a1cde04e1b6830e018
PYTHON_AIOSQLITE_SETUP_TYPE = distutils
PYTHON_AIOSQLITE_LICENSE = MIT
PYTHON_AIOSQLITE_LICENSE_FILES = LICENSE

$(eval $(python-package))
