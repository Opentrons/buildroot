################################################################################
#
# python-uvicorn
#
################################################################################

PYTHON_UVICORN_VERSION = 0.11.2
PYTHON_UVICORN_SOURCE = uvicorn-$(PYTHON_UVICORN_VERSION).tar.gz
PYTHON_UVICORN_SITE = https://files.pythonhosted.org/packages/5c/ed/37f168f52814d09feaf0b4f6894704a17209f84219773def5b8b14a060dc
PYTHON_UVICORN_SETUP_TYPE = setuptools

$(eval $(python-package))
