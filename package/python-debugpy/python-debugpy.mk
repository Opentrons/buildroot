################################################################################
#
# python-debugpy
#
################################################################################

PYTHON_DEBUGPY_VERSION = 1.8.0
PYTHON_DEBUGPY_SOURCE = debugpy-$(PYTHON_DEBUGPY_VERSION).zip
PYTHON_DEBUGPY_SITE = https://files.pythonhosted.org/packages/61/fe/0486b90b9ac0d9afced236fdfe6e54c2f45b7ef09225210090f23dc6e48a
PYTHON_DEBUGPY_SETUP_TYPE = setuptools
PYTHON_DEBUGPY_LICENSE = MIT
PYTHON_DEBUGPY_LICENSE_FILES = LICENSE.txt

define PYTHON_DEBUGPY_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(PYTHON_DEBUGPY_DL_DIR)/$(PYTHON_DEBUGPY_SOURCE)
	mv $(@D)/debugpy-$(PYTHON_DEBUGPY_VERSION)/* $(@D)
	$(RM) -r $(@D)/debugpy-$(PYTHON_DEBUGPY_VERSION)
	$(RM) -rfv $(@D)/src/debugpy/_vendored/pydevd/test*
endef

$(eval $(python-package))
