################################################################################
#
# python-pexpect
#
################################################################################

PYTHON_PEXPECT_VERSION = 4.8.0
PYTHON_PEXPECT_SOURCE = pexpect-$(PYTHON_PEXPECT_VERSION).tar.gz
PYTHON_PEXPECT_SITE = https://files.pythonhosted.org/packages/e5/9b/ff402e0e930e70467a7178abb7c128709a30dfb22d8777c043e501bc1b10
PYTHON_PEXPECT_LICENSE = ISC
PYTHON_PEXPECT_LICENSE_FILES = LICENSE
PYTHON_PEXPECT_SETUP_TYPE = distutils

# async.py is not usable with Python 2, and removing is the solution
# recommended by upstream:
# https://github.com/pexpect/pexpect/issues/290
ifeq ($(BR2_PACKAGE_PYTHON),y)
define PYTHON_PEXPECT_REMOVE_ASYNC_PY
	$(RM) $(@D)/pexpect/_async.py
endef
PYTHON_PEXPECT_POST_PATCH_HOOKS += PYTHON_PEXPECT_REMOVE_ASYNC_PY
endif

HOST_PYTHON_PEXPECT_DEPENDENCIES = host-python-ptyprocess
PYTHON_PEXPECT_DEPENDENCIES = python-ptyprocess

$(eval $(python-package))
$(eval $(host-python-package))
