#!/bin/sh 

cd ..
docker build -t mosaiksoftware/debian:onbuild .
docker push mosaiksoftware/debian:onbuild

docker run --name debian-export mosaiksoftware/debian:onbuild && docker export debian-export | docker import - mosaiksoftware/debian:latest
docker stop debian-export 
docker rm debian-export
docker push mosaiksoftware/debian
