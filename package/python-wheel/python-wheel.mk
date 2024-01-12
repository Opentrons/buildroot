################################################################################
#
# python-wheel
#
################################################################################

PYTHON_WHEEL_VERSION = 0.42.0
PYTHON_WHEEL_SOURCE = wheel-$(PYTHON_WHEEL_VERSION).tar.gz
PYTHON_WHEEL_SITE = https://files.pythonhosted.org/packages/b0/b4/bc2baae3970c282fae6c2cb8e0f179923dceb7eaffb0e76170628f9af97b
PYTHON_WHEEL_SETUP_TYPE = pep517
PYTHON_WHEEL_LICENSE = MIT
PYTHON_WHEEL_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
