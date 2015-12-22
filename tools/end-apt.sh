#!/bin/sh
#cleanup
rm -rf /var/lib/apt/lists
#rm /tmp/*
apt-get autoremove -y
apt-get clean
