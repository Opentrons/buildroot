################################################################################
#
# python-uvicorn
#
################################################################################

PYTHON_UVICORN_VERSION = 0.11.3
PYTHON_UVICORN_SOURCE = uvicorn-$(PYTHON_UVICORN_VERSION).tar.gz
PYTHON_UVICORN_SITE = https://files.pythonhosted.org/packages/48/30/cd48ac0eb03bd3007191ea20fc34457a45187fb430fdc30c0f6b9059bee0
PYTHON_UVICORN_SETUP_TYPE = setuptools

$(eval $(python-package))
