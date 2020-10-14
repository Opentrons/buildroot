################################################################################
#
# python-pyzmq
#
################################################################################

PYTHON_PYZMQ_VERSION = 19.0.2
PYTHON_PYZMQ_SOURCE = pyzmq-$(PYTHON_PYZMQ_VERSION).tar.gz
PYTHON_PYZMQ_SITE = https://files.pythonhosted.org/packages/05/77/7483975d84fe1fd24cc67881ba7810e0e7b3ee6c2a0e002a5d6703cca49b
PYTHON_PYZMQ_SETUP_TYPE = distutils
PYTHON_PYZMQ_LICENSE = FIXME: please specify the exact BSD version, GNU Library or Lesser General Public License (LGPL)
PYTHON_PYZMQ_LICENSE_FILES = bundled/zeromq/COPYING examples/LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
