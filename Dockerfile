FROM debian:10-slim
# We're stuck on Debian 10 (which will go EOL around 2022-08) because
# Debian 11 upgrades GNU Make to v4.3, which breaks Buildroot's build system.
#
# Upstream Buildroot has fixes for this (try grepping their CHANGES file for
# "4.3"), but those commits aren't currently in this fork.

ARG filter_output

VOLUME /buildroot

RUN apt-get -y update &&\
  apt-get -y install build-essential wget file cpio python rsync unzip bc libncurses-dev git curl


RUN wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.23.0.tar.xz &&\
  tar xf ./crosstool-* &&\
  rm crosstool*.tar.xz

ENV FILTER=${filter_output}


ENTRYPOINT ["/buildroot/in_docker.sh"]
CMD ["all"]
