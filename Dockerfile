FROM bcleonard/calibre:v2021.12.29.01

# set version labels
ARG BUILD_DATE
ARG VERSION
ARG COPS_VERSION=1.1.3
ARG COPS_URL="https://github.com/seblucas/cops/releases/download/${COPS_VERSION}/cops-${COPS_VERSION}.zip"
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

# add list-books.sh
ADD list-books.sh /scripts/
RUN chmod 755 /scripts/list-books.sh

# add startup-cops.sh
ADD startup-cops.sh /scripts/
RUN chmod 755 /scripts/startup-cops.sh

# Expose port
EXPOSE 80

# Set the COPS Library Name
ENV COPSLIBRARYNAME=COPS

CMD ["/scripts/startup-cops.sh"]
