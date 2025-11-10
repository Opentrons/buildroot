FROM debian:bookworm-20250203
# We're stuck on Debian 10 (which will go EOL around 2022-08) because
# Debian 11 upgrades GNU Make to v4.3, which breaks Buildroot's build system.
#
# Upstream Buildroot has fixes for this (try grepping their CHANGES file for
# "4.3"), but those commits aren't currently in this fork.

ARG filter_output
# We need tar >= 1.35
ARG TAR_VERSION="1.35"

ENV DEBIAN_FRONTEND=noninteractive

VOLUME /buildroot

RUN apt-get -o APT::Retries=3 update -y
RUN apt-get -o APT::Retries=3 install -y --no-install-recommends \
        bc \
        build-essential \
        bzr \
        ca-certificates \
        cmake \
        cpio \
        curl \
        cvs \
        file \
        flake8 \
        g++ \
        git \
        libncurses5-dev \
        locales \
        mercurial \
        openssh-server \
        python3 \
        python3-flake8 \
        python3-magic \
        python3-nose2 \
        python3-pexpect \
        python3-pytest \
        qemu-system-arm \
        qemu-system-misc \
        qemu-system-x86 \
        rsync \
        shellcheck \
        subversion \
        unzip \
        wget \
        && \
    apt-get -y autoremove && \
    apt-get -y clean

# Build host-tar
RUN curl -sfL https://ftpmirror.gnu.org/tar/tar-${TAR_VERSION}.tar.xz | \
    tar -Jx -C /tmp && \
    cd /tmp/tar-${TAR_VERSION} && \
    FORCE_UNSAFE_CONFIGURE=1 ./configure \
        --disable-year2038 && \
    make && \
    make install && \
    rm -rf /tmp/tar-${TAR_VERSION}


RUN wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.23.0.tar.xz &&\
  tar xf ./crosstool-* &&\
  rm crosstool*.tar.xz

# To be able to generate a toolchain with locales, enable one UTF-8 locale
RUN sed -i 's/# \(en_US.UTF-8\)/\1/' /etc/locale.gen && \
    /usr/sbin/locale-gen


ENV FILTER=${filter_output}
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8


ENTRYPOINT ["/buildroot/in_docker.sh"]
CMD ["all"]
