################################################################################
#
# python-pyzmq
#
################################################################################

PYTHON_PYZMQ_VERSION = 24.0.1
PYTHON_PYZMQ_SOURCE = pyzmq-$(PYTHON_PYZMQ_VERSION).tar.gz
PYTHON_PYZMQ_SITE = https://files.pythonhosted.org/packages/46/0d/b06cf99a64d4187632f4ac9ddf6be99cd35de06fe72d75140496a8e0eef5
PYTHON_PYZMQ_SETUP_TYPE = setuptools
PYTHON_PYZMQ_LICENSE = FIXME: please specify the exact BSD version, GNU Library or Lesser General Public License (LGPL)
PYTHON_PYZMQ_LICENSE_FILES = bundled/zeromq/COPYING examples/LICENSE

ifeq ($(BR2_PACKAGE_ZEROMQ_DRAFTS),y)
PYTHON_PYZMQ_BUILD_OPTS += --enable-drafts
endif

$(eval $(python-package))
$(eval $(host-python-package))
