################################################################################
#
# python-ipython
#
################################################################################

PYTHON_IPYTHON_VERSION = 7.31.1
PYTHON_IPYTHON_SOURCE = ipython-$(PYTHON_IPYTHON_VERSION).tar.gz
PYTHON_IPYTHON_SITE = https://files.pythonhosted.org/packages/fb/39/c1947dc1bb993a35469ca474535cb3214c91f5f9a7752a1fcbd9b6b37dde
PYTHON_IPYTHON_LICENSE = BSD-3-Clause
PYTHON_IPYTHON_LICENSE_FILES = COPYING.rst LICENSE
PYTHON_IPYTHON_CPE_ID_VENDOR = ipython
PYTHON_IPYTHON_CPE_ID_PRODUCT = ipython
PYTHON_IPYTHON_SETUP_TYPE = distutils
HOST_PYTHON_IPYTHON_DEPENDENCIES = host-python-pickleshare host-python-pexpect host-python-pygments host-python-decorator host-python-traitlets host-python-prompt-toolkit host-python-simplegeneric
PYTHON_IPYTHON_DEPENDENCIES = python-pickleshare python-pexpect python-pygments python-decorator python-traitlets python-prompt-toolkit python-simplegeneric

$(eval $(python-package))
$(eval $(host-python-package))
