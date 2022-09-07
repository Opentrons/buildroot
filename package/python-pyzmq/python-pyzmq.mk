################################################################################
#
# python-pyzmq
#
################################################################################

PYTHON_PYZMQ_VERSION = 19.0.2
PYTHON_PYZMQ_SOURCE = pyzmq-$(PYTHON_PYZMQ_VERSION).tar.gz
PYTHON_PYZMQ_SITE = https://files.pythonhosted.org/packages/05/77/7483975d84fe1fd24cc67881ba7810e0e7b3ee6c2a0e002a5d6703cca49b
PYTHON_PYZMQ_LICENSE = LGPL-3.0+, BSD-3-Clause, Apache-2.0
# Apache license only online: http://www.apache.org/licenses/LICENSE-2.0
PYTHON_PYZMQ_LICENSE_FILES = COPYING.LESSER COPYING.BSD
PYTHON_PYZMQ_DEPENDENCIES = zeromq
HOST_PYTHON_PYZMG_DEPENDENCIES = host-zeromq
PYTHON_PYZMQ_SETUP_TYPE = distutils
PYTHON_PYZMQ_BUILD_OPTS = --zmq=$(STAGING_DIR)/usr

# Due to issues with cross-compiling, hardcode to the zeromq in BR
define PYTHON_PYZMQ_PATCH_ZEROMQ_VERSION
	$(SED) 's/##ZEROMQ_VERSION##/$(ZEROMQ_VERSION)/' \
		$(@D)/buildutils/detect.py
endef

PYTHON_PYZMQ_POST_PATCH_HOOKS += PYTHON_PYZMQ_PATCH_ZEROMQ_VERSION

ifeq ($(BR2_PACKAGE_ZEROMQ_DRAFTS),y)
PYTHON_PYZMQ_BUILD_OPTS += --enable-drafts
endif

ifneq ($(BR2_PACKAGE_PYTHON_PYZMQ_TESTS),y)
define PYTHON_PYZMQ_REMOVE_TESTS
   rm -rf $(TARGET_DIR)/usr/lib/python*/site-packages/zmq/tests
endef
PYTHON_PYZMQ_POST_INSTALL_TARGET_HOOKS += PYTHON_PYZMQ_REMOVE_TESTS
endif


$(eval $(python-package))
$(eval $(host-python-package))
