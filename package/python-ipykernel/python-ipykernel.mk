################################################################################
#
# python-ipykernel
#
################################################################################

PYTHON_IPYKERNEL_VERSION = 6.20.2
PYTHON_IPYKERNEL_SOURCE = ipykernel-$(PYTHON_IPYKERNEL_VERSION).tar.gz
PYTHON_IPYKERNEL_SITE = https://files.pythonhosted.org/packages/87/c0/16e5656247203e7ae67e528f580561c9b54166145c10b46e3ad117984902
PYTHON_IPYKERNEL_SETUP_TYPE = hatch
PYTHON_IPYKERNEL_LICENSE = BSD-3-Clause
PYTHON_IPYKERNEL_DEPENDENCIES = python-comm \
								python-ipython \
								python-jupyter_client \
								python-traitlets \
								python-tornado \
								python-matplotlib-inline \
								python-pyzmq \
								python-psutil \
								python-nest-asyncio \
								python-packaging \
								host-python-hatch-vcs
define PYTHON_IPYKERNEL_INSTALL_LOGOS
	cp $(PYTHON_IPYKERNEL_PKGDIR)/*.png $(@D)/data_kernelspec/
	cp $(PYTHON_IPYKERNEL_PKGDIR)/*.svg $(@D)/data_kernelspec/
endef
PYTHON_IPYKERNEL_POST_PATCH_HOOKS += PYTHON_IPYKERNEL_INSTALL_LOGOS
$(eval $(python-package))
