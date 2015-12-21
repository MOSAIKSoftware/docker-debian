#!/bin/bash

# the idea of this script is to remove everything not needed to run the current binary(s) 
echo "THIS SCRIPT WILL DESTROY THE PACKAGE MANAGER!!!"
echo "BE WARNED!!!!!!!!"

# remove std. include dirs
rm -rf /usr/include /usr/local/include

# remove any .cpp .c or .h file on the system
find / -name "*.[ch]" -o -name "*.cpp" -exec rm "{}" \;

# remove static libs
find / -name "*.a" -exec rm "{}" \;

# delete debian leftovers - the pakage manager would be of no use from here on
rm -rf /var/backups
rm -rf /var/cache/{apt,debconf}
rm -rf /var/lib/{apt,dpkg}


#delete package manager so nobody uses it
rm -f /usr/bin/dpkg*
rm -f /usr/bin/apt-*

# some ldd magic perhaps? remove all so s not needed by running binarys
# list of required bins and so /bin/sh,/bin/bash,/lib/libc..,
need_bin="/bin/bash,/bin/sh"

# TBD: loop

# set all dirs immutable - exept for locations know to change

# TBD
