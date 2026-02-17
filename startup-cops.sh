#!/bin/bash

#
# determine cops library name
#
if [ -z "${COPSLIBRARYNAME}" ]
then
  COPSLIBRARYNAME="COPS"
fi
 
#
# update the cops library name
#
LOCAL_CONFIG="/usr/share/nginx/html/cops/config/local.php"
sed -i "s/COPS/${COPSLIBRARYNAME}/" ${LOCAL_CONFIG}

#
# start php-fpm
#
mkdir -p /run/php
/usr/sbin/php-fpm8.4 -D

#
# start nginx
#
/usr/sbin/nginx -g "daemon off;" -c /scripts/nginx.conf
