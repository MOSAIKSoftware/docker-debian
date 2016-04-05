FROM debian:jessie
MAINTAINER  Chrisitan Holzberger <ch@mosaiksoftware.de>
ENV DEBIAN_FRONTEND noninteractive
##### PACKAGE INSTALLATION #####
COPY tools/set-selections.sh /sbin/set-selections
COPY tools/begin-apt.sh /sbin/begin-apt
COPY tools/end-apt.sh /sbin/end-apt
COPY tools/wait-for-tcp-socket.sh /bin/wait-for-tcp-socket
COPY config/etc /etc
COPY selections /selections

RUN chmod a+x /sbin/begin-apt /sbin/set-selections /sbin/end-apt /bin/wait-for-socket && \
	echo "Yes, do as I say!" | apt-get remove -y --force-yes --purge --auto-remove systemd udev && \
	apt-get clean && \
	begin-apt && \
	set-selections base && \
	end-apt
##### START CUSTOM SCRIPT####
ONBUILD COPY selections /selections
ONBUILD COPY config/etc /etc

CMD dpkg --get-selections
