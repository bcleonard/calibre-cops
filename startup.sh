#!/bin/bash

#
# add crontab for root
#
crontab /scripts/crontab

#
# start crond
#
/usr/sbin/crond

#
# start php-fpm
/usr/sbin/php-fpm -D

#
# start nginx
#
/usr/sbin/nginx -g "daemon off;" -c /scripts/nginx.conf
