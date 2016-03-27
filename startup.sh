#!/bin/bash

#
# start php-fpm
/usr/sbin/php-fpm -D

#
# start nginx
#
/usr/sbin/nginx -g "daemon off;" -c /scripts/nginx.conf
