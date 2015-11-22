FROM bcleonard/calibre:latest
MAINTAINER Bradley Leonard <bradley@stygianresearch.com> 

# install cops
RUN dnf -y install git nginx php-gd php-fpm php-xml php-pdo php-mbstring php-intl

#
# add cops.conf for nginx
ADD cops.conf /etc/nginx/conf.d/cops.conf

# create directories
RUN mkdir /usr/share/nginx/html/apps

# add cops
RUN git clone https://github.com/seblucas/cops.git /usr/share/nginx/html/apps/

# add cops configuration
ADD config_local.php /usr/share/nginx/html/apps/config_local.php 

# add the startup.sh script
ADD startup.sh /scripts/startup.sh
RUN chmod 755 /scripts/startup.sh

# add the list-books.sh script
ADD list-books.sh /scripts/list-books.sh
RUN chmod 755 /scripts/list-books.sh

# Expose port
EXPOSE 80

CMD ["/scripts/startup.sh"]
