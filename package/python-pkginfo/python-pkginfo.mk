################################################################################
#
# python-pkginfo
#
################################################################################

PYTHON_PKGINFO_VERSION = 1.7.1
PYTHON_PKGINFO_SOURCE = pkginfo-$(PYTHON_PKGINFO_VERSION).tar.gz
PYTHON_PKGINFO_SITE = https://files.pythonhosted.org/packages/23/3f/f2251c754073cda0f00043a707cba7db103654722a9afed965240a0b2b43
PYTHON_PKGINFO_SETUP_TYPE = setuptools
PYTHON_PKGINFO_LICENSE = MIT
PYTHON_PKGINFO_LICENSE_FILES = LICENSE.txt

$(eval $(host-python-package))
