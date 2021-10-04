################################################################################
#
# python-cachecontrol
#
################################################################################

PYTHON_CACHECONTROL_VERSION = 0.12.6
PYTHON_CACHECONTROL_SOURCE = CacheControl-$(PYTHON_CACHECONTROL_VERSION).tar.gz
PYTHON_CACHECONTROL_SITE = https://files.pythonhosted.org/packages/44/b9/9a1d4349824ae14de4052e84802a0c372fff1fd2bd6668f7e9efe91ac11d
PYTHON_CACHECONTROL_SETUP_TYPE = setuptools
PYTHON_CACHECONTROL_LICENSE = Apache-2.0
PYTHON_CACHECONTROL_LICENSE_FILES = LICENSE.txt

$(eval $(host-python-package))
