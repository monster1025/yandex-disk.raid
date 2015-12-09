#!/bin/bash
NUM=1
while IFS='' read -r line || [[ -n "$line" ]]; do
   IFS=':' read -ra ADDR <<< "$line"
   let "NUM++"
done < "secrets"

#make a key
if [ $NUM == 1 ]; then
  echo "Error: secrets file is empty. Place login:pass there."
  exit
fi

sudo docker build -t monster/yandex-disk.raid .

