FROM debian:jessie
MAINTAINER  Chrisitan Holzberger <ch@mosaiksoftware.de>
ENV PATH /usr/local/go/bin:$PATH
##### PACKAGE INSTALLATION #####
COPY tools /bin/

COPY selections /selections
COPY tools/runlevel /sbin/runlevel
ENV GOPATH /usr/src/confd
ENV GOBIN /usr/src/confd/bin
ENV TEST "mosaiksoftware/debian"
# Custom Builds

COPY config /etc

# make use of docker caching

RUN chmod a+x /bin/run-build 

COPY build.d/ /build/
RUN run-build /build/

##### START CUSTOM SCRIPT####
ONBUILD COPY selections /selections
ONBUILD COPY config /etc
ONBUILD COPY build.d /build
ONBUILD RUN run-build /build
ENTRYPOINT [ "/bin/docker-entrypoint" ]
CMD  dpkg --get-selections
