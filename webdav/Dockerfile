FROM monster/yandex-disk.raid
MAINTAINER Monster <dima@yandex5.ru>

RUN apt-get update
RUN apt-get -y install apache2 openssl apache2-utils supervisor
RUN a2enmod dav dav_fs ssl; a2ensite default-ssl
RUN mkdir -p /var/lock/apache2; chown www-data /var/lock/apache2
RUN rm /var/www/html/index.html; touch /var/www/html/index.html
RUN mkdir -p /mnt/yandex.disk.decrypted/
RUN chmod 777 /mnt/yandex.disk.decrypted/

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/apache2

EXPOSE 443

ADD configure /
ADD webdav.conf /
ADD supervisor.conf /etc/supervisor/conf.d/

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
