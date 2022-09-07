################################################################################
#
# python-greenlet
#
################################################################################

PYTHON_GREENLET_VERSION = 1.1.2
PYTHON_GREENLET_SOURCE = greenlet-$(PYTHON_GREENLET_VERSION).tar.gz
PYTHON_GREENLET_SITE = https://files.pythonhosted.org/packages/0c/10/754e21b5bea89d0e73f99d60c83754df7cc64db74f47d98ab187669ce341
PYTHON_GREENLET_SETUP_TYPE = setuptools
PYTHON_GREENLET_LICENSE = MIT, PSF-2.0
PYTHON_GREENLET_LICENSE_FILES = LICENSE LICENSE.PSF
PYTHON_GREENLET_ENV = GREENLET_TEST_CPP=no

ifneq ($(BR2_PACKAGE_PYTHON_GREENLET_TESTS),y)
define PYTHON_GREENLET_REMOVE_TESTS
    rm -rf $(TARGET_DIR)/usr/lib/python*/site-packages/greenlet/tests
endef
PYTHON_GREENLET_POST_INSTALL_TARGET_HOOKS += PYTHON_GREENLET_REMOVE_TESTS
endif

$(eval $(python-package))
$(eval $(host-python-package))
