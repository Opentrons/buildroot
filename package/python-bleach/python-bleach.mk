################################################################################
#
# python-bleach
#
################################################################################

PYTHON_BLEACH_VERSION = 3.1.0
PYTHON_BLEACH_SOURCE = bleach-$(PYTHON_BLEACH_VERSION).tar.gz
PYTHON_BLEACH_SITE = https://files.pythonhosted.org/packages/78/5a/0df03e8735cd9c75167528299c738702437589b9c71a849489d00ffa82e8
PYTHON_BLEACH_SETUP_TYPE = setuptools
PYTHON_BLEACH_LICENSE = Apache-2.0
PYTHON_BLEACH_LICENSE_FILES = LICENSE bleach/_vendor/html5lib-1.0.1.dist-info/LICENSE.txt

$(eval $(python-package))
