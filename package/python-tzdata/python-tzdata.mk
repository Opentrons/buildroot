################################################################################
#
# python-tzdata
#
################################################################################

PYTHON_TZDATA_VERSION = 2025.2
PYTHON_TZDATA_SOURCE = tzdata-$(PYTHON_TZDATA_VERSION).tar.gz
PYTHON_TZDATA_SITE = https://files.pythonhosted.org/packages/95/32/1a225d6164441be760d75c2c42e2780dc0873fe382da3e98a2e1e48361e5
PYTHON_TZDATA_SETUP_TYPE = setuptools
PYTHON_TZDATA_LICENSE = Apache-2.0
PYTHON_TZDATA_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_PYTHON_TZDATA_DEFER_INSTALL),y)
define PYTHON_TZDATA_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/deferred-py-installs
	cp $(@D)/dist/*.whl $(TARGET_DIR)/usr/share/deferred-py-installs/
	mkdir -p $(TARGET_DIR)/etc/systemd/system/install-deferred-packages.service.d
	echo '[Service]' > $(TARGET_DIR)/etc/systemd/system/install-deferred-packages.service.d/tzdata.conf
	echo 'ExecStart=/usr/bin/pip install --no-deps --root=/var/system-packages --upgrade /usr/share/deferred-py-installs/tzdata-$(PYTHON_TZDATA_VERSION)-py2.py3-none-any.whl' >> $(TARGET_DIR)/etc/systemd/system/install-deferred-packages.service.d/tzdata.conf
endef
endif
$(eval $(python-package))
