################################################################################
#
# python-nbclassic
#
################################################################################

PYTHON_NBCLASSIC_VERSION = 0.4.7
PYTHON_NBCLASSIC_SOURCE = nbclassic-$(PYTHON_NBCLASSIC_VERSION).tar.gz
PYTHON_NBCLASSIC_SITE = https://files.pythonhosted.org/packages/ae/5a/6bdc0b20e5f6894fef0be99e0a9132bd8467fd082164fdbdbd37464416f6
PYTHON_NBCLASSIC_SETUP_TYPE = pep517
PYTHON_NBCLASSIC_LICENSE = BSD-3-Clause

PYTHON_NBCLASSIC_DEPENDENCIES = host-python-jupyter-packaging \
								host-python-babel \
								python-jinja2 \
								python-tornado \
								python-pyzmq \
								python-ipython-genutils \
								python-traitlets \
								python-jupyter_core \
								python-jupyter_client \
								python-nbformat \
								python-nbconvert \
								python-ipykernel \
								python-send2trash \
								python-terminado \
								python-prometheus_client
ifeq ($(BR2_PACKAGE_PYTHON_NBCLASSIC_DEFER_INSTALL),y)
define PYTHON_NBCLASSIC_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/deferred-py-installs
	cp $(@D)/dist/*.whl $(TARGET_DIR)/usr/share/deferred-py-installs/
	mkdir -p $(TARGET_DIR)/etc/systemd/system/install-deferred-packages.service.d
	echo '[Service]' >$(TARGET_DIR)/etc/systemd/system/install-deferred-packages.service.d/nbclassic.conf
	echo 'ExecStart=/usr/bin/pip install --no-deps --root=/var/system-packages --upgrade /usr/share/deferred-py-installs/nbclassic-$(PYTHON_NBCLASSIC_VERSION)-py3-none-any.whl' >>$(TARGET_DIR)/etc/systemd/system/install-deferred-packages.service.d/nbclassic.conf
endef
endif


define PYTHON_NBCLASSIC_USERS
	jupyter -1 jupyter -1 * - - -
endef

$(eval $(python-package))
