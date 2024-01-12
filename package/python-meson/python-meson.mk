################################################################################
#
# python-meson
#
################################################################################

PYTHON_MESON_VERSION = 1.2.1
PYTHON_MESON_SOURCE = meson-$(PYTHON_MESON_VERSION).tar.gz
PYTHON_MESON_SITE = https://files.pythonhosted.org/packages/f2/21/3326fe66aa091b3653d12affd1c3928e17c9ac386708ec42b4fad87eefac
PYTHON_MESON_DEPENDENCIES = host-python-numpy host-python-cython 
PYTHON_MESON_SETUP_TYPE = setuptools
PYTHON_MESON_LICENSE = BSD
PYTHON_MESON_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
