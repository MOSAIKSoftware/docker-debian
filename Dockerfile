FROM debian:jessie
MAINTAINER  Chrisitan Holzberger <ch@mosaiksoftware.de>
ENV DEBIAN_FRONTEND noninteractive
ENV PATH /usr/local/go/bin:$PATH
##### PACKAGE INSTALLATION #####
COPY tools/set-selections.sh /sbin/set-selections
COPY tools/begin-apt.sh /sbin/begin-apt
COPY tools/end-apt.sh /sbin/end-apt
COPY tools/wait-for-tcp-socket.sh /bin/wait-for-tcp-socket
COPY config-base /etc
COPY selections /selections

RUN chmod a+x /sbin/begin-apt /sbin/set-selections /sbin/end-apt /bin/wait-for-tcp-socket && \
	echo "Yes, do as I say!" | apt-get remove -y --force-yes --purge --auto-remove systemd udev && \
	apt-get clean && \
	begin-apt && \
	set-selections base && \
	end-apt
##### START CUSTOM SCRIPT####
COPY config /etc
ONBUILD COPY selections /selections
ONBUILD COPY config /etc

ENV GOPATH /usr/src/confd
ENV GOBIN /usr/src/confd/bin
RUN \
wget https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz -O /go.tar.gz \
&& cd /usr/local \
&& tar xzf /go.tar.gz \
&& rm /go.tar.gz \
&& git clone https://github.com/kelseyhightower/confd.git /usr/src/confd \
&& cd /usr/src/confd \
&& go get \
&& go build \ 
&& cp /usr/src/confd/bin/confd /bin/confd \
&& rm -rf /usr/src/confd \
&& rm -rf /usr/local/go 
#-a -installsuffix cgo -ldflags '-extld ld -extldflags -static' -a -x

CMD confd -onetime -backend env && dpkg --get-selections
