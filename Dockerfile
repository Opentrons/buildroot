FROM debian:stable-slim

VOLUME /buildroot

RUN apt-get -y update &&\
  apt-get -y install build-essential wget file cpio python rsync unzip bc

RUN wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.23.0.tar.xz && tar xf ./crosstool-* && rm crosstool*.tar.xz

ENTRYPOINT ["make", "-C", "/buildroot"]
CMD ["opentrons"]
