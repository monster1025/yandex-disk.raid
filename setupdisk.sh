#!/bin/bash
#no history this time, sorry
unset HISTFILE 

DOMAIN=yandex.ru

NUM=1
while IFS='' read -r line || [[ -n "$line" ]]; do
   IFS=':' read -ra ADDR <<< "$line"
   USER="${ADDR[0]}"
   PASS="${ADDR[1]}"

   #echo "$USER-$PASS-$NUM"

   sudo echo "/var/webdav/yandex.disk-$NUM $USER@$DOMAIN $PASS" >> /etc/davfs2/secrets
   sudo echo "https://webdav.yandex.ru /var/webdav/yandex.disk-$NUM davfs gid=$USER@$DOMAIN,uid=$USER@$DOMAIN,noauto 0 0" >> /etc/fstab
   sudo mkdir -p /var/webdav/yandex.disk-$NUM
   sudo echo "mount /var/webdav/yandex.disk-$NUM" >> /etc/rc.local

   FOLDERS+=",/var/webdav/yandex.disk-$NUM"
   let "NUM++"
done < "secrets"

rm -rf /secrets

#will put config here
sudo mkdir /etc/encfs/

#make a key
if [ ! -d /root/.encfs/ ]; then
  sudo mkdir /root/.encfs/
fi
sudo chmod 700 ~/.encfs/

#setup mhddfs (for disk "union")
sudo mkdir -p /mnt/yandex.disk.encrypted
sudo echo "mhddfs#${FOLDERS:1} /mnt/yandex.disk.encrypted fuse mlimit=100%,logfile=/var/log/mhddfs.log 0 0" >> /etc/fstab
sudo echo "mount /mnt/yandex.disk.encrypted" >> /etc/rc.local

#setup encfs
sudo mkdir /mnt/yandex.disk.decrypted
sudo echo "/runit.sh" >> /etc/rc.local

#move exit to end of file
sed -i 's/exit 0//g' /etc/rc.local
echo "exit 0" >> /etc/rc.local


#self remove
rm setupdisk.sh
