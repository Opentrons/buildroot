################################################################################
#
# python-pandocfilters
#
################################################################################

PYTHON_PANDOCFILTERS_VERSION = 1.4.2
PYTHON_PANDOCFILTERS_SOURCE = pandocfilters-$(PYTHON_PANDOCFILTERS_VERSION).tar.gz
PYTHON_PANDOCFILTERS_SITE = https://files.pythonhosted.org/packages/4c/ea/236e2584af67bb6df960832731a6e5325fd4441de001767da328c33368ce
PYTHON_PANDOCFILTERS_SETUP_TYPE = distutils
PYTHON_PANDOCFILTERS_LICENSE = BSD-3-Clause
PYTHON_PANDOCFILTERS_LICENSE_FILES = LICENSE

$(eval $(python-package))
