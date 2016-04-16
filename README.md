# Custom Debian image

Customized version of the debian base image. 
Removes systemd and udev and adds them to the ignore list.

Does not install documentation of packages. 

## Selections

This images provides an easy way to add packages to a derived image 
create a dir /selections add place a file inside this dir e.g. `yourPackages` 
which looks like:
`git install
zsh install`

then call `RUN set-selections yourPackages` inside your derived Dockerfile. 

## apt and dpkg preferences

place apt settings in `config/apt` and dpkg preferences in `config/dpkg` the will be included in the new image automaticaly. 

## confd
Including confd.
See: https://github.com/kelseyhightower/confd/blob/master/docs/quick-start-guide.md


## Shrinking

This image has been flatened running `docker run --name debian mosaiksoftware/debian:onbuild && docker export debian | docker import - mosaiksoftware/debian:latest` which reduces its size to 43 MB.

However we lose ONBUILD capabilities doing so. 

Add this to your dockerfile if you dont use `:onbuild` : 
`COPY selections /selections/
COPY config/etc /etc`
