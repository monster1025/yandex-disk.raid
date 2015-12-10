#!/bin/bash
#make a key
if [ $1 == "run" ]; then
 docker run  --privileged -v /srv/yandex.disk/.encfs/:/root/.encfs/ -it -e PASSWORD=$( read -p "Password: " -s PASSWORD && echo $PASSWORD ) -p 443:443 monster/yandex-webdav
 exit
fi
docker build --rm -t monster/yandex-webdav .
