################################################################################
#
# python-parso
#
################################################################################

PYTHON_PARSO_VERSION = 0.3.4
PYTHON_PARSO_SOURCE = parso-$(PYTHON_PARSO_VERSION).tar.gz
PYTHON_PARSO_SITE = https://files.pythonhosted.org/packages/01/70/d9fa1a10aed70c192815aac7fd3eb38ef49aa5ab9cb36129ae22c8ecbf1f
PYTHON_PARSO_SETUP_TYPE = setuptools
PYTHON_PARSO_LICENSE = MIT
PYTHON_PARSO_LICENSE_FILES = LICENSE.txt test/normalizer_issue_files/LICENSE docs/_themes/flask/LICENSE

$(eval $(python-package))
