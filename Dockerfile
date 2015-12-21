FROM debian:jessie
MAINTAINER  Chrisitan Holzberger <ch@mosaiksoftware.de>

ENV DEBIAN_FRONTEND noninteractive
##### PACKAGE INSTALLATION #####
COPY tools/set-selections.sh /sbin/set-selections
COPY config/apt/* /etc/apt/
COPY config/dpkg/* /etc/dpkg/

RUN chomd 777 /set-selections.sh && \
	echo "Yes, do as I say!" | apt-get remove -y --force-yes --purge --auto-remove systemd udev
##### START CUSTOM SCRIPT####
ONBUILD COPY selections/ /selections/
ONBUILD COPY config/apt/* /etc/apt/
ONBUILD COPY config/dpkg/* /etc/dpkg/

CMD dpkg --get-selections
