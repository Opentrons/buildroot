################################################################################
#
# python-evdev
#
################################################################################

PYTHON_EVDEV_VERSION = 1.3.0
PYTHON_EVDEV_SOURCE = evdev-$(PYTHON_EVDEV_VERSION).tar.gz
PYTHON_EVDEV_SITE = https://files.pythonhosted.org/packages/89/83/5f5635fd0d91a08ac355dd9ca9bde34bfa6b29a5c59f703ad83d1ad0bf34
PYTHON_EVDEV_SETUP_TYPE = bdist_wheel
PYTHON_EVDEV_LICENSE = BSD-3-Clause
PYTHON_EVDEV_LICENSE_FILES = LICENSE
PYTHON_EVDEV_BUILD_OPTS = build_ext build_ecodes

$(eval $(python-package))
