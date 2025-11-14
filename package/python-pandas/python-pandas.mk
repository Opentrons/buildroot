################################################################################
#
# python-pandas
#
################################################################################

PYTHON_PANDAS_VERSION = 2.3.3
PYTHON_PANDAS_SOURCE = pandas-$(PYTHON_PANDAS_VERSION).tar.gz
PYTHON_PANDAS_SITE = https://files.pythonhosted.org/packages/33/01/d40b85317f86cf08d853a4f495195c73815fdf205eef3993821720274518
PYTHON_PANDAS_DEPENDENCIES = \
				python-numpy \
				host-python-numpy \
				host-python-cython \
				host-python-versioneer \
				host-python-meson-python \
				python-dateutil \
				python-pytz \
				python-tzdata \


PYTHON_PANDAS_LICENSE = BSD
PYTHON_PANDAS_LICENSE_FILES = LICENSE

ifneq ($(BR2_PACKAGE_PYTHON_PANDAS_TESTS),y)
define PYTHON_PANDAS_REMOVE_TESTS
   rm -rf $(TARGET_DIR)/usr/lib/python*/site-packages/pandas/tests
endef
PYTHON_PANDAS_POST_INSTALL_TARGET_HOOKS += PYTHON_PANDAS_REMOVE_TESTS
endif

define PYTHON_PANDAS_REMOVE_PYCACHE
	find $(TARGET_DIR)/usr/lib/python3.12/site-packages/pandas -path '*/__pycache__/*' -delete
	find $(TARGET_DIR)/usr/lib/python3.12/site-packages/pandas -name __pycache__ -delete
endef


ifeq ($(BR2_PACKAGE_PYTHON_PANDAS_DEFER_INSTALL),y)
define PYTHON_PANDAS_RECOMPRESS_FOR_DEFERRED_INSTALL
	$(PYTHON_PANDAS_REMOVE_PYCACHE)
	mkdir -p $(TARGET_DIR)/usr/share/deferred-py-installs
	tar -c -z \
		-C$(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages \
		-f$(TARGET_DIR)/usr/share/deferred-py-installs/pandas-$(PYTHON_PANDAS_VERSION).tar.gz \
		--remove-files \
		pandas
endef
PYTHON_PANDAS_POST_INSTALL_TARGET_HOOKS += PYTHON_PANDAS_RECOMPRESS_FOR_DEFERRED_INSTALL
endif

$(eval $(meson-package))
