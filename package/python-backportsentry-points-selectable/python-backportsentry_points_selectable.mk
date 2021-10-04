################################################################################
#
# python-backportsentry_points_selectable
#
################################################################################

PYTHON_BACKPORTSENTRY_POINTS_SELECTABLE_VERSION = 1.1.0
PYTHON_BACKPORTSENTRY_POINTS_SELECTABLE_SOURCE = backports.entry_points_selectable-$(PYTHON_BACKPORTSENTRY_POINTS_SELECTABLE_VERSION).tar.gz
PYTHON_BACKPORTSENTRY_POINTS_SELECTABLE_SITE = https://files.pythonhosted.org/packages/e4/7e/249120b1ba54c70cf988a8eb8069af1a31fd29d42e3e05b9236a34533533
PYTHON_BACKPORTSENTRY_POINTS_SELECTABLE_SETUP_TYPE = setuptools
PYTHON_BACKPORTSENTRY_POINTS_SELECTABLE_LICENSE = MIT
PYTHON_BACKPORTSENTRY_POINTS_SELECTABLE_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
