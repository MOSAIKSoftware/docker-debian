#!/bin/sh 
set -e
REPO=mosaiksoftware/debian

SCRIPTPATH=$(realpath "$0")
DIRNAME=$(dirname "$SCRIPTPATH")

cd $(dirname "$DIRNAME")

echo " >>> Building Image: $REPO"

docker build -t $REPO:latest .

echo ">>> Flattening normal Image"
#IMG=$(docker run -d $REPO:tmp /bin/true) 


#docker export $IMG | \
#docker import \
#		--change 'ENTRYPOINT \[/bin/dinit,-r,/bin/docker-entrypoint\]' \
#		--change 'CMD dpkg --get-selections' \
#		- $REPO:latest

#echo ">>> Flattening onbuild Image"
# 	docker export $IMG | \
#	docker import \
#		--change "ENTRYPOINT [ /bin/dinit, '-r', /bin/docker-entrypoint ]" \
#		--change 'CMD dpkg --get-selections' \
#		--change 'ONBUILD COPY config /etc' \
#		--change 'ONBUILD COPY selections /selections' \
#		- $REPO:onbuild

#docker stop $IMG
#docker rm $IMG


#echo ">>> Tagging latest image"
#docker tag $REPO:latest $REPO

#echo ">>> Pushing onbuild variant"
#docker push $REPO:onbuild

#echo ">>> Pushing flattened image"
docker push $REPO
docker push $REPO:latest

