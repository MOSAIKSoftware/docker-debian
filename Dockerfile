FROM debian:jessie
MAINTAINER  Chrisitan Holzberger <ch@mosaiksoftware.de>
ENV PATH /usr/local/go/bin:$PATH
ENV DEBIAN_FRONTEND noninteractive
##### PACKAGE INSTALLATION #####
COPY tools /bin/
COPY config-base /etc
COPY selections /selections
COPY tools/runlevel /sbin/runlevel
ENV GOPATH /usr/src/confd
ENV GOBIN /usr/src/confd/bin
ENV TEST "mosaiksoftware/debian"
RUN chmod a+x /sbin/runlevel && \
chmod a+x /bin/* && \
mkdir /docker/ && \
mkdir /docker/container_init.d && \
mkdir /docker/periodic_hourly.d && \
mkdir /docker/periodic_daily.d 



RUN chmod a+x /bin/begin-apt /bin/set-selections /bin/end-apt /bin/wait-for-tcp-socket  \
&&	echo "Yes, do as I say!" | apt-get remove -y --force-yes --purge --auto-remove systemd udev \
&&	apt-get clean \ 
&&	begin-apt \
&&	set-selections base \
&&	end-apt 

RUN wget https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz -O /go.tar.gz \
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

RUN echo "Europe/Stockholm" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata && \
	export LANGUAGE=en_US.UTF-8 && \
	export LANG=en_US.UTF-8 && \
	export LC_ALL=en_US.UTF-8 && \
	locale-gen en_US.UTF-8 && \
	dpkg-reconfigure locales 



##### START CUSTOM SCRIPT####
ONBUILD COPY config /etc
ONBUILD COPY selections /selections
COPY config /etc
ENTRYPOINT [ "/bin/docker-entrypoint" ]
CMD  dpkg --get-selections
