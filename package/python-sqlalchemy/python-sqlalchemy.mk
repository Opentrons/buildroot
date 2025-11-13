################################################################################
#
# python-sqlalchemy
#
################################################################################

PYTHON_SQLALCHEMY_VERSION = 1.4.51
PYTHON_SQLALCHEMY_SOURCE = SQLAlchemy-$(PYTHON_SQLALCHEMY_VERSION).tar.gz
PYTHON_SQLALCHEMY_SITE = https://files.pythonhosted.org/packages/c8/56/5a8dcb01ef7b68904f2a3224343d4ab3674b5cc8f48f7cefb0701bc75ab8
PYTHON_SQLALCHEMY_SETUP_TYPE = setuptools
PYTHON_SQLALCHEMY_LICENSE = MIT
PYTHON_SQLALCHEMY_LICENSE_FILES = LICENSE
PYTHON_SQLALCHEMY_CPE_ID_VENDOR = sqlalchemy
PYTHON_SQLALCHEMY_CPE_ID_PRODUCT = sqlalchemy

define PYTHON_SQLALCHEMY_REMOVE_TESTS
	rm -rf $(TARGET_DIR)/usr/lib/python*/site-packages/sqlalchemy/testing
endef
PYTHON_SQLALCHEMY_POST_INSTALL_TARGET_HOOKS += PYTHON_SQLALCHEMY_REMOVE_TESTS
$(eval $(python-package))
