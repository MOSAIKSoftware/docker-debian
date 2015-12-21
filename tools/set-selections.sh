#!/bin/sh

sel="$1"
#update package database
apt-get update 
apt-get upgrade -y 

#load packages
avail=`mktemp` 
apt-cache dumpavail > "$avail" 
dpkg --merge-avail "$avail"
rm -f "$avail" 
dpkg --set-selections < "/selections/$sel"
apt-get -u dselect-upgrade -y 

#cleanup
rm -rf /var/lib/apt/lists
rm /tmp/*
apt-get autoremove -y
apt-get clean
