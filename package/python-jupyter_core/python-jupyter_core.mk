################################################################################
#
# python-jupyter_core
#
################################################################################

PYTHON_JUPYTER_CORE_VERSION = 4.4.0
PYTHON_JUPYTER_CORE_SOURCE = jupyter_core-$(PYTHON_JUPYTER_CORE_VERSION).tar.gz
PYTHON_JUPYTER_CORE_SITE = https://files.pythonhosted.org/packages/b6/2d/2804f4de3a95583f65e5dcb4d7c8c7183124882323758996e867f47e72af
PYTHON_JUPYTER_CORE_SETUP_TYPE = distutils
PYTHON_JUPYTER_CORE_LICENSE = BSD-3-Clause

ifneq ($(BR2_PACKAGE_PYTHON_JUPYTER_CORE_TESTS),y)
define PYTHON_JUPYTER_CORE_REMOVE_TESTS
    rm -rf $(TARGET_DIR)/usr/lib/python*/site-packages/jupyter_core/tests
endef
PYTHON_JUPYTER_CORE_POST_INSTALL_TARGET_HOOKS += PYTHON_JUPYTER_CORE_REMOVE_TESTS
endif

$(eval $(python-package))
$(eval $(host-python-package))
