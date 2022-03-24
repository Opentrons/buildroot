################################################################################
#
# python-prompt-toolkit
#
################################################################################

PYTHON_PROMPT_TOOLKIT_VERSION = 3.0.20
PYTHON_PROMPT_TOOLKIT_SOURCE = prompt_toolkit-$(PYTHON_PROMPT_TOOLKIT_VERSION).tar.gz
PYTHON_PROMPT_TOOLKIT_SITE = https://files.pythonhosted.org/packages/b4/56/9ab5868f34ab2657fba7e2192f41316252ab04edbbeb2a8583759960a1a7
PYTHON_PROMPT_TOOLKIT_SETUP_TYPE = setuptools
PYTHON_PROMPT_TOOLKIT_LICENSE = BSD-3-Clause
PYTHON_PROMPT_TOOLKIT_LICENSE_FILES = LICENSE

HOST_PYTHON_PROMPT_TOOLKIT_DEPENDENCIES = host-python-wcwidth host-python-six
PYTHON_PROMPT_TOOLKIT_DEPENDENCIES = python-wcwidth python-six

$(eval $(python-package))
$(eval $(host-python-package))
