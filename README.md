# yandex-disk.raid - Yandex.Disk Encrypted Raid
####Docker container to make "RAID" of Yandex.Disks with encryption

####Thanks to DebianZILLA for manual :)

Fill secrets file with your yandex.disk accounts data
login:pass (one pair by one line, login is login, not an email; no comments or other 'trash' allowed).
> echo "lolov:pass" > secrets

Build a container:
> ./build.sh

First run:
>docker run --privileged --name yandex-disk.raid -v /srv/yandex.disk/.encfs/:/root/.encfs/ -ti 50816dfafbfd /sbin/my_init

Params are: -v host-dir:container-dir, also change an id :)

Recommended settings in first run:
>Please choose from one of the following options: x
>The following cipher algorithms are available:1
>Selected key size: 256
>filesystem block size: 4096
>The following filename encoding algorithms are available: 1 (Block)
>Enable filename initialization vector chaining? – Yes;
>Enable per-file initialization vectors? – Yes;
>Enable filename to IV header chaining? – Yes;
>Enable block authentication code headers on every block in a file? – No
>Add random bytes to each block header: 8
>Enable file-hole pass-through? – Yes.

!!! Make backup of key and encfs,xml after container start! You will lose data otherwithe.

Container start example:
> docker start yandex.disk-raid

Attach to command line:
> docker exec -it yandex-disk.raid bash

Also you can change 
>cat /root/.encfs/key
to
>read -s -p "Enter Password: "
in runit.sh file and you will enter password on each container startup (password is saved in file by default)...

Paths:
/mnt/yandex.disk.decrypted -- result disk directory
/mnt/yandex.disk.encrypted -- "big" encrypted container
/var/webdav/yandex.disk-N -- "small" webdav disks
