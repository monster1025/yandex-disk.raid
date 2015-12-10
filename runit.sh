#!/bin/bash

#make a key if not exist
if [ ! -d /root/.encfs/ ]; then
  sudo mkdir /root/.encfs/
fi
sudo chmod 700 /root/.encfs/

if [ ! -f /root/.encfs/key ]; then
  RANDPASS=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w50 | head -n1)
  sudo echo "$RANDPASS" > ~/.encfs/key
fi

if [ -f /root/.encfs/encfs6.xml ]; then
  sudo chmod 600 /root/.encfs/encfs6.xml
fi
sudo chmod 700 /root/.encfs/
sudo chmod 600 /root/.encfs/key


export ENCFS6_CONFIG=/root/.encfs/encfs6.xml
encfs /mnt/yandex.disk.encrypted /mnt/yandex.disk.decrypted --extpass="cat /root/.encfs/key" --public
