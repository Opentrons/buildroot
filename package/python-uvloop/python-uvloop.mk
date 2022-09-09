################################################################################
#
# python-uvloop
#
################################################################################

PYTHON_UVLOOP_VERSION = 0.16.0
PYTHON_UVLOOP_SOURCE = uvloop-$(PYTHON_UVLOOP_VERSION).tar.gz
PYTHON_UVLOOP_SITE = https://files.pythonhosted.org/packages/ab/d9/22bbffa8f8d7e075ccdb29e8134107adfb4710feb10039f9d357db8b589c
PYTHON_UVLOOP_SETUP_TYPE = setuptools
PYTHON_UVLOOP_LICENSE = Apache-2.0, MIT
PYTHON_UVLOOP_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT
PYTHON_UVLOOP_BUILD_OPTS = build_ext --inplace --use-system-libuv
PYTHON_UVLOOP_INSTALL_TARGET_OPTS = build_ext --inplace --use-system-libuv
PYTHON_UVLOOP_DEPENDENCIES = libuv

ifneq ($(BR2_PACKAGE_PYTHON_UVLOOP_SOURCE),y)
define PYTHON_UVLOOP_TRIM_SOURCE
   find $(TARGET_DIR)/usr/lib/python*/site-packages/uvloop/ -type f -regex '.*\.c\|.*\.pyx\|.*\.pxd' -exec rm {} \;
endef
PYTHON_UVLOOP_POST_INSTALL_TARGET_HOOKS += PYTHON_UVLOOP_TRIM_SOURCE
endif

$(eval $(python-package))
