#!/bin/sh 

cd ..
docker build -t mosaiksoftware/debian:onbuild .
docker push mosaiksoftware/debian:onbuild

docker run --name debian mosaiksoftware/debian:onbuild && docker export debian | docker import - mosaiksoftware/debian:latest
docker push mosaiksoftware/debian
