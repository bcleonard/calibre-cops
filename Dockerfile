FROM bcleonard/calibre:latest
MAINTAINER Bradley Leonard <bradley@stygianresearch.com> 

# install calibre cronie
RUN dnf -y install nginx php-gd php-fpm php-xml php-mbstring php-intl php-pdo tar&&\
  dnf -y clean all

# add cops
#RUN git clone https://github.com/seblucas/cops.git /usr/share/nginx/html/cops
#RUN mv /usr/share/nginx/html/cops/* /usr/share/nginx/html
#RUN rm /usr/share/nginx/html/index.html
RUN mkdir /usr/share/nginx/html/cops &&\
  curl -L https://github.com/seblucas/cops/archive/1.0.0RC3.tar.gz | tar -xvpzf - -C /usr/share/nginx/html/cops --strip-components=1

# add cops configuration
ADD config_local.php /usr/share/nginx/html/cops/config_local.php 

# add cops.conf for nginx
#ADD cops.conf /etc/nginx/conf.d/cops.conf

# add new nginx.conf
ADD nginx.conf /scripts/nginx.conf

# create directories
#RUN mkdir /data & mkdir /scripts

# add crontab
#ADD crontab /scripts/crontab

# add the scripts
ADD *.sh /scripts/
RUN chmod 755 /scripts/*.sh

# Expose port
EXPOSE 80

CMD ["/scripts/startup.sh"]
