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
