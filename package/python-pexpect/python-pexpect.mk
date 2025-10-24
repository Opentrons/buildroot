################################################################################
#
# python-pexpect
#
################################################################################

PYTHON_PEXPECT_VERSION = 4.9.0
PYTHON_PEXPECT_SOURCE = pexpect-$(PYTHON_PEXPECT_VERSION).tar.gz
PYTHON_PEXPECT_SITE = https://files.pythonhosted.org/packages/42/92/cc564bf6381ff43ce1f4d06852fc19a2f11d180f23dc32d9588bee2f149d
PYTHON_PEXPECT_LICENSE = ISC
PYTHON_PEXPECT_LICENSE_FILES = LICENSE
PYTHON_PEXPECT_SETUP_TYPE = setuptools

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
