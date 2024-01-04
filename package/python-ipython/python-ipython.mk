################################################################################
#
# python-ipython
#
################################################################################

PYTHON_IPYTHON_VERSION = 8.16.1
PYTHON_IPYTHON_SOURCE = ipython-$(PYTHON_IPYTHON_VERSION).tar.gz
PYTHON_IPYTHON_SITE = https://files.pythonhosted.org/packages/17/ff/23116d95eeb974bd08b57b7d477fb57d68446e04718b6c330d2854ad9923
PYTHON_IPYTHON_LICENSE = BSD-3-Clause
PYTHON_IPYTHON_LICENSE_FILES = COPYING.rst
PYTHON_IPYTHON_SETUP_TYPE = setuptools
HOST_PYTHON_IPYTHON_DEPENDENCIES = host-python-pickleshare host-python-pexpect host-python-pygments host-python-decorator host-python-traitlets host-python-prompt-toolkit host-python-simplegeneric
PYTHON_IPYTHON_DEPENDENCIES = python-pickleshare python-pexpect python-pygments python-decorator python-traitlets python-prompt-toolkit python-simplegeneric

$(eval $(python-package))
$(eval $(host-python-package))
