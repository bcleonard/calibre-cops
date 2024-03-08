FROM bcleonard/calibre:v2024.03.07.01

# set version labels
ARG BUILD_DATE
ARG VERSION
ARG COPS_VERSION=2.4.1
ARG COPS_URL="https://github.com/mikespub-org/seblucas-cops/releases/download/${COPS_VERSION}/cops-${COPS_VERSION}.zip"
ARG COPS_DIR="/usr/share/nginx/html/cops"

LABEL MAINTAINER bradley leonard <bradley@leonard.pub>

RUN \
  echo "---===>>> prep system <<<===---" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    nginx \
    php-fpm \
    php-gd \
    php-intl \
    php-json \
    php-mbstring \
    php-sqlite3 \
    php-xml \
    php-zip \
    unzip && \
  echo "---===>>> install cops <<<===---" && \
  mkdir -p "$COPS_DIR" && \
  curl -o \
    /tmp/cops.zip -L \
    "$COPS_URL" && \
  unzip /tmp/cops.zip -d "$COPS_DIR" && \
  echo "---===>>> cleanup <<<===---" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/

# add cops configuration
ADD config_local.php /usr/share/nginx/html/cops/config_local.php 

# add new nginx.conf
ADD nginx.conf /scripts/nginx.conf

# add new fastcgi_params
ADD fastcgi_params /scripts/fastcgi_params

# add test.php
#ADD test.php /usr/share/nginx/html/cops/test.php

# add list-books.sh
ADD list-books.sh /scripts/list-books.sh
RUN chmod 755 /scripts/list-books.sh

# add startup-cops.sh
ADD startup-cops.sh /scripts/startup-cops.sh
RUN chmod 755 /scripts/startup-cops.sh

# Expose port
EXPOSE 80

CMD ["/scripts/startup-cops.sh"]
