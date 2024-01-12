################################################################################
#
# python-meson-python
#
################################################################################

PYTHON_MESON_PYTHON_VERSION = 0.13.1
PYTHON_MESON_PYTHON_SOURCE = meson_python-$(PYTHON_MESON_PYTHON_VERSION).tar.gz
PYTHON_MESON_PYTHON_SITE = https://files.pythonhosted.org/packages/fb/54/9551a0810f3f95f761c31d902d3706b7bfe67253e81b33c0994b2c0f9b3b
PYTHON_MESON_PYTHON_DEPENDENCIES = host-python-meson host-python-tomli host-python-pyproject-metadata
PYTHON_MESON_PYTHON_SETUP_TYPE = pep517
PYTHON_MESON_PYTHON_LICENSE = MIT
PYTHON_MESON_PYTHON_LICENSE_FILES = LICENSES/MIT.txt

$(eval $(python-package))
$(eval $(host-python-package))
