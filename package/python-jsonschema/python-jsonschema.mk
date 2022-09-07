################################################################################
#
# python-jsonschema
#
################################################################################

PYTHON_JSONSCHEMA_VERSION = 3.0.2
PYTHON_JSONSCHEMA_SOURCE = jsonschema-$(PYTHON_JSONSCHEMA_VERSION).tar.gz
PYTHON_JSONSCHEMA_SITE = https://files.pythonhosted.org/packages/92/d2/8768983d6e4bb1478ea08e7bc186304f47b99c22bfd711caa8e9becb0361
PYTHON_JSONSCHEMA_SETUP_TYPE = setuptools
PYTHON_JSONSCHEMA_LICENSE = MIT
PYTHON_JSONSCHEMA_LICENSE_FILES = COPYING json/LICENSE
PYTHON_JSONSCHEMA_DEPENDENCIES = host-python-vcversioner

ifneq ($(BR2_PACKAGE_PYTHON_JSONSCHEMA_TESTS),y)
define PYTHON_JSONSCHEMA_REMOVE_TESTS
	find $(TARGET_DIR)/usr/lib/python*/site-packages/jsonschema/ \
		-name tests -prune -exec rm -rf {} \;
    rm -rf $(TARGET_DIR)/usr/lib/python*/site-packages/jsonschema/tests
endef
PYTHON_JSONSCHEMA_POST_INSTALL_TARGET_HOOKS += PYTHON_JSONSCHEMA_REMOVE_TESTS
endif

$(eval $(python-package))
