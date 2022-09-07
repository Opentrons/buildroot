################################################################################
#
# python-traitlets
#
################################################################################

PYTHON_TRAITLETS_VERSION = 5.1.0
PYTHON_TRAITLETS_SOURCE = traitlets-$(PYTHON_TRAITLETS_VERSION).tar.gz
PYTHON_TRAITLETS_SITE = https://files.pythonhosted.org/packages/d5/bc/37d490908e7ac949614d62767db3c86f37bc5adb6129d378c35859a75b87
PYTHON_TRAITLETS_LICENSE = BSD-3-Clause
PYTHON_TRAITLETS_LICENSE_FILES = COPYING.md
PYTHON_TRAITLETS_SETUP_TYPE = distutils

HOST_PYTHON_TRAITLETS_DEPENDENCIES = host-python-ipython-genutils host-python-six
PYTHON_TRAITLETS_DEPENDENCIES = python-ipython-genutils python-six

ifneq ($(BR2_PACKAGE_PYTHON_TRAITLETS_TESTS),y)
define PYTHON_TRAITLETS_REMOVE_TESTS
    rm -rf $(TARGET_DIR)/usr/lib/python*/site-packages/traitlets/tests
endef
PYTHON_TRAITLETS_POST_INSTALL_TARGET_HOOKS += PYTHON_TRAITLETS_REMOVE_TESTS
endif


$(eval $(python-package))
$(eval $(host-python-package))
