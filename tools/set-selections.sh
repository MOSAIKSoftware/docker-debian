#!/bin/sh
set -e
sel="$1"
release="${2:-stable}"
echo running: 
xargs -a "/selections/$sel" echo apt-get install --no-install-recommends -y -t $release 
xargs -a "/selections/$sel" apt-get install --no-install-recommends -y -t $release 
