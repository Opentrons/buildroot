################################################################################
#
# python-uvloop
#
################################################################################

PYTHON_UVLOOP_VERSION = 0.18.0
PYTHON_UVLOOP_SOURCE = uvloop-$(PYTHON_UVLOOP_VERSION).tar.gz
PYTHON_UVLOOP_SITE = https://files.pythonhosted.org/packages/80/f9/94d2d914d351c7d5db80e102fb0d7ab3bbb798e8322ab71a9fe9f8bfa31b
PYTHON_UVLOOP_SETUP_TYPE = setuptools
PYTHON_UVLOOP_LICENSE = Apache-2.0, MIT
PYTHON_UVLOOP_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT
PYTHON_UVLOOP_BUILD_OPTS = build_ext --inplace --use-system-libuv
PYTHON_UVLOOP_INSTALL_TARGET_OPTS = build_ext --inplace --use-system-libuv
PYTHON_UVLOOP_DEPENDENCIES = libuv

$(eval $(python-package))
