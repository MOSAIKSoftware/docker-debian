FROM debian:jessie
MAINTAINER  Chrisitan Holzberger <ch@mosaiksoftware.de>

### APT_PROXY
ARG APT_PROXY_HTTP="false"
ARG APT_PROXY_HTTPS="false"
ARG APT_PROXY_FTP="false"
ARG SYS_PROXY_HTTP=""
ARG SYS_PROXY_HTTPS=""
ARG SYS_PROXY_FTP=""
ONBUILD ARG APT_PROXY_HTTP="false"
ONBUILD ARG APT_PROXY_HTTPS="false"
ONBUILD ARG APT_PROXY_FTP="false"
ONBUILD ARG SYS_PROXY_HTTP=""
ONBUILD ARG SYS_PROXY_HTTPS=""
ONBUILD ARG SYS_PROXY_FTP=""
ENV PATH /commands:/usr/local/go/bin:$PATH

RUN ln -s /service /etc/service.d
#### PACKAGE INSTALLATION #####
COPY tools /bin/

COPY selections /selections
COPY tools/runlevel /sbin/runlevel
COPY commands /commands
COPY service /etc/service.d
ENV GOPATH /usr/src/confd
ENV GOBIN /usr/src/confd/bin
ENV TEST "mosaiksoftware/debian"
# Custom Builds
COPY config /etc

# make use of docker caching
RUN chmod a+x /bin/run-build 
RUN chmod a+x /commands

COPY build.d/ /build/
### HACK FAILING BUILD ###
RUN echo -e "Config:\n\t$APT_PROXY_HTTP\n\t$APT_PROXY_HTTPS\n\t$APT_PROXY_FTP\n\t$SYS_PROXY_HTTP\n\t$SYS_PROXY_HTTPS\n\t$SYS_PROXY_FTP"
RUN run-build /build/



##### START CUSTOM SCRIPT####
ONBUILD COPY selections /selections
ONBUILD COPY config /etc
ONBUILD COPY build.d /build
ONBUILD RUN echo -e "Config:\n\t$APT_PROXY_HTTP\n\t$APT_PROXY_HTTPS\n\t$APT_PROXY_FTP\n\t$SYS_PROXY_HTTP\n\t$SYS_PROXY_HTTPS\n\t$SYS_PROXY_FTP"
ONBUILD RUN run-build /build
ONBUILD COPY commands /commands
ONBUILD RUN chmod a+x /commands/*
ONBUILD COPY service /etc/service.d
ENTRYPOINT [ "/bin/docker-entrypoint" ]
CMD ['dpkg', '--get-selections']
