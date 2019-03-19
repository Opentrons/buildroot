################################################################################
#
# python-nbconvert
#
################################################################################

PYTHON_NBCONVERT_VERSION = 5.4.1
PYTHON_NBCONVERT_SOURCE = nbconvert-$(PYTHON_NBCONVERT_VERSION).tar.gz
PYTHON_NBCONVERT_SITE = https://files.pythonhosted.org/packages/cd/b8/fccf6aaaddd9fb44341ff8453a45f3e7e9035beac80a48f4ae9149a0390f
PYTHON_NBCONVERT_SETUP_TYPE = setuptools
PYTHON_NBCONVERT_LICENSE = BSD-3-Clause
PYTHON_NBCONVERT_LICENSE_FILES = LICENSE

PYTHON_NBCONVERT_DEPENDENCIES=python-mistune python-jinja2 python-pygments python-traitlets python-jupyter_core python-nbformat python-entrypoints python-bleach python-pandocfilters python-testpath python-defusedxml

$(eval $(python-package))
