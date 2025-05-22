################################################################################
#
# python-flit-scm
#
################################################################################

PYTHON_FLIT_SCM_VERSION = 1.7.0
PYTHON_FLIT_SCM_SOURCE = flit_scm-$(PYTHON_FLIT_SCM_VERSION).tar.gz
PYTHON_FLIT_SCM_SITE = https://files.pythonhosted.org/packages/e2/99/961b062461652435b6ad9042d2ffdd75e327b36936987c2073aa784334d5
PYTHON_FLIT_SCM_SETUP_TYPE = flit
PYTHON_FLIT_SCM_LICENSE = MIT
PYTHON_FLIT_SCM_LICENSE_FILES = LICENSE
PYTHON_FLIT_SCM_DEPENDENCIES = host-python-setuptools-scm host-python-tomli

$(eval $(python-package))
$(eval $(host-python-package))
