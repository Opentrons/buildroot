################################################################################
#
# python-setuptools-scm
#
################################################################################

PYTHON_SETUPTOOLS_SCM_VERSION = 5.0.1
PYTHON_SETUPTOOLS_SCM_SOURCE = setuptools_scm-$(PYTHON_SETUPTOOLS_SCM_VERSION).tar.gz
PYTHON_SETUPTOOLS_SCM_SITE = https://files.pythonhosted.org/packages/af/df/f8aa8a78d4d29e0cffa4512e9bc223ed02f24893fe1837c6cee2749ebd67
PYTHON_SETUPTOOLS_SCM_LICENSE = MIT
PYTHON_SETUPTOOLS_SCM_LICENSE_FILES = LICENSE
PYTHON_SETUPTOOLS_SCM_SETUP_TYPE = setuptools

HOST_PYTHON_SETUPTOOLS_SCM_DEPENDENCIES = \
	host-python-packaging \
	host-python-typing-extensions

$(eval $(host-python-package))
