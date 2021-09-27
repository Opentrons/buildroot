################################################################################
#
# python-filelock
#
################################################################################

PYTHON_FILELOCK_VERSION = 3.1.0
PYTHON_FILELOCK_SOURCE = filelock-$(PYTHON_FILELOCK_VERSION).tar.gz
PYTHON_FILELOCK_SITE = https://files.pythonhosted.org/packages/40/6e/75062649204602805de42a1faa614e16a57ee3d3331302a1de2d7c4db4e3
PYTHON_FILELOCK_SETUP_TYPE = setuptools
PYTHON_FILELOCK_LICENSE = Public Domain
PYTHON_FILELOCK_LICENSE_FILES = LICENSE docs/license.rst

$(eval $(host-python-package))
