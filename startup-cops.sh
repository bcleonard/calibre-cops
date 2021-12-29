#!/bin/bash

#
# update the cops library name
#
sed -i "s/COPS/${COPSLIBRARYNAME}/" /usr/share/nginx/html/cops/config_local.php 

#
# start php-fpm
#
#mkdir -p /run/php-fpm
#/usr/sbin/php-fpm -D
mkdir -p /run/php
/usr/sbin/php-fpm7.4 -D

#
# start nginx
#
/usr/sbin/nginx -g "daemon off;" -c /scripts/nginx.conf
