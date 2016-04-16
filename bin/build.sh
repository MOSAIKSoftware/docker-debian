#!/bin/sh 

cd ..
docker build -t mosaiksoftware/debian:onbuild .
docker push mosaiksoftware/debian:onbuild

docker run --name debianexport mosaiksoftware/debian:onbuild /bin/true && docker export debianexport | docker import - mosaiksoftware/debian:latest
docker stop debianexport 
docker rm debianexport
docker push mosaiksoftware/debian
