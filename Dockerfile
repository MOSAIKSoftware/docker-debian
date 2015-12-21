FROM debian:jessie
MAINTAINER  Chrisitan Holzberger <ch@mosaiksoftware.de>

ENV DEBIAN_FRONTEND noninteractive
##### PACKAGE INSTALLATION #####
COPY tools/set-selections.sh /sbin/set-selections
COPY config/etc /etc

RUN chmod 777 /sbin/set-selections && \
	echo "Yes, do as I say!" | apt-get remove -y --force-yes --purge --auto-remove systemd udev && \
	apt-get clean
##### START CUSTOM SCRIPT####
ONBUILD COPY selections /selections
ONBUILD COPY config/etc /etc

CMD dpkg --get-selections
