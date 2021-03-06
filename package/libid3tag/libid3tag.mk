################################################################################
#
# libid3tag
#
################################################################################

LIBID3TAG_VERSION = 0.15.1b
LIBID3TAG_SITE = http://downloads.sourceforge.net/project/mad/libid3tag/$(LIBID3TAG_VERSION)
LIBID3TAG_LICENSE = GPL-2.0+
LIBID3TAG_LICENSE_FILES = COPYING COPYRIGHT
LIBID3TAG_INSTALL_STAGING = YES
LIBID3TAG_DEPENDENCIES = zlib

# Force autoreconf to be able to use a more recent libtool script, that
# is able to properly behave in the face of a missing C++ compiler.
LIBID3TAG_AUTORECONF = YES

$(eval $(autotools-package))
