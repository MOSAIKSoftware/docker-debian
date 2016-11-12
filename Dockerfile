FROM debian:jessie
MAINTAINER  Chrisitan Holzberger <ch@mosaiksoftware.de>
ENV PATH /commands:/usr/local/go/bin:$PATH
##### PACKAGE INSTALLATION #####
COPY tools /bin/

COPY selections /selections
COPY tools/runlevel /sbin/runlevel
COPY commands /commands
COPY service /etc/service
ENV GOPATH /usr/src/confd
ENV GOBIN /usr/src/confd/bin
ENV TEST "mosaiksoftware/debian"
# Custom Builds
COPY config /etc

# make use of docker caching
RUN chmod a+x /bin/run-build 
RUN chmod a+x /commands

COPY build.d/ /build/
RUN run-build /build/

##### START CUSTOM SCRIPT####
ONBUILD COPY selections /selections
ONBUILD COPY config /etc
ONBUILD COPY service /etc/service
ONBUILD COPY build.d /build
ONBUILD RUN run-build /build
ONBUILD COPY commands /commands
ONBUILD RUN chmod a+x /commands/*
ONBUILD COPY service /etc/service
ENTRYPOINT [ "/bin/docker-entrypoint" ]
CMD ['dpkg', '--get-selections']
