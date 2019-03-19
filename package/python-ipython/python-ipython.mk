################################################################################
#
# python-ipython
#
################################################################################

PYTHON_IPYTHON_VERSION = 8.8.0
PYTHON_IPYTHON_SOURCE = ipython-$(PYTHON_IPYTHON_VERSION).tar.gz
PYTHON_IPYTHON_SITE = https://files.pythonhosted.org/packages/f5/39/89664d8c3e4dfb0a73862cbbff8eb4028a1e3d4305da80ab0a493848ed9b
PYTHON_IPYTHON_LICENSE = BSD-3-Clause
PYTHON_IPYTHON_LICENSE_FILES = COPYING.rst
PYTHON_IPYTHON_SETUP_TYPE = distutils
HOST_PYTHON_IPYTHON_DEPENDENCIES = host-python-pickleshare host-python-pexpect host-python-pygments host-python-decorator host-python-traitlets host-python-prompt-toolkit host-python-simplegeneric
PYTHON_IPYTHON_DEPENDENCIES = python-pickleshare python-pexpect python-pygments python-decorator python-traitlets python-prompt-toolkit python-simplegeneric

$(eval $(python-package))
$(eval $(host-python-package))
