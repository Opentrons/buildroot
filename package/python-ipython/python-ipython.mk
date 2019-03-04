################################################################################
#
# python-ipython
#
################################################################################

PYTHON_IPYTHON_VERSION = 5.8.0
PYTHON_IPYTHON_SOURCE = ipython-$(PYTHON_IPYTHON_VERSION).tar.gz
PYTHON_IPYTHON_SITE = https://files.pythonhosted.org/packages/41/a6/2d25314b1f9375639d8f8e0f8052e8cec5df511d3449f22c4f1c2d8cb3c6
PYTHON_IPYTHON_LICENSE = BSD-3-Clause
PYTHON_IPYTHON_LICENSE_FILES = COPYING.rst
PYTHON_IPYTHON_SETUP_TYPE = distutils
HOST_PYTHON_IPYTHON_DEPENDENCIES = host-python-pickleshare host-python-pexpect host-python-pygments host-python-decorator host-python-traitlets host-python-prompt-toolkit host-python-simplegeneric
PYTHON_IPYTHON_DEPENDENCIES = python-pickleshare python-pexpect python-pygments python-decorator python-traitlets python-prompt-toolkit python-simplegeneric

$(eval $(python-package))
$(eval $(host-python-package))
