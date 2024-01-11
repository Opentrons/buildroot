################################################################################
#
# python-parso
#
################################################################################

PYTHON_PARSO_VERSION = 0.8.3
PYTHON_PARSO_SOURCE = parso-$(PYTHON_PARSO_VERSION).tar.gz
PYTHON_PARSO_SITE = https://files.pythonhosted.org/packages/a2/0e/41f0cca4b85a6ea74d66d2226a7cda8e41206a624f5b330b958ef48e2e52
PYTHON_PARSO_SETUP_TYPE = setuptools
PYTHON_PARSO_LICENSE = MIT
PYTHON_PARSO_LICENSE_FILES = LICENSE.txt test/normalizer_issue_files/LICENSE docs/_themes/flask/LICENSE

$(eval $(python-package))
