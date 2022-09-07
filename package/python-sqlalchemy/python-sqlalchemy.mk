################################################################################
#
# python-sqlalchemy
#
################################################################################

PYTHON_SQLALCHEMY_VERSION = 1.4.32
PYTHON_SQLALCHEMY_SOURCE = SQLAlchemy-$(PYTHON_SQLALCHEMY_VERSION).tar.gz
PYTHON_SQLALCHEMY_SITE = https://files.pythonhosted.org/packages/7a/9f/ace7376a3ab45adf0f7169a5d8d60707c04b171b72a18bb23d505f83f362
PYTHON_SQLALCHEMY_SETUP_TYPE = setuptools
PYTHON_SQLALCHEMY_LICENSE = MIT
PYTHON_SQLALCHEMY_LICENSE_FILES = LICENSE

ifneq ($(BR2_PACKAGE_PYTHON_SQLALCHEMY_TESTS),y)
define PYTHON_SQLALCHEMY_REMOVE_TESTS
   rm -rf $(TARGET_DIR)/usr/lib/python*/site-packages/sqlalchemy/testing
endef
PYTHON_SQLALCHEMY_POST_INSTALL_TARGET_HOOKS += PYTHON_SQLALCHEMY_REMOVE_TESTS
endif

$(eval $(python-package))
