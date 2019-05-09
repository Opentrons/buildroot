FROM debian:stable-slim

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
