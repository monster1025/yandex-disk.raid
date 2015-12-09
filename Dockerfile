FROM phusion/baseimage:latest
MAINTAINER Monster <dima@yandex5.ru>

#secrets file
ADD /secrets secrets
ADD /setupdisk.sh setupdisk.sh
ADD /runit.sh runit.sh

RUN sudo apt-get -q update && \
    sudo apt-get -yq install davfs2 mhddfs encfs && \
    /setupdisk.sh

CMD ["/sbin/my_init", "/runit.sh"]
