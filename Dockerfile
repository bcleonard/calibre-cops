FROM bcleonard/calibre:2016.12.13.1
MAINTAINER Bradley Leonard <bradley@stygianresearch.com> 

# install calibre cronie
RUN dnf -y install nginx php-gd php-fpm php-xml php-mbstring php-intl php-pdo tar&&\
  dnf -y clean all

# add cops
RUN mkdir /usr/share/nginx/html/cops &&\
  curl -L https://github.com/seblucas/cops/archive/1.0.0RC3.tar.gz | tar -xvpzf - -C /usr/share/nginx/html/cops --strip-components=1

# add cops configuration
ADD config_local.php /usr/share/nginx/html/cops/config_local.php 

# add new nginx.conf
ADD nginx.conf /scripts/nginx.conf

# add list-books.sh
ADD list-books.sh /scripts/
RUN chmod 755 /scripts/list-books.sh

# add remove-books.sh
#ADD remove-books.sh /scripts/
#RUN chmod 755 /scripts/remove-books.sh

# add startup-cops.sh
ADD startup-cops.sh /scripts/
RUN chmod 755 /scripts/startup-cops.sh

# Expose port
EXPOSE 80

# Set the COPS Library Name
ENV COPSLIBRARYNAME=COPS

CMD ["/scripts/startup-cops.sh"]
