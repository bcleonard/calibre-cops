#!/bin/sh

LIBNAME=/data/library
CALIBREDB=/usr/bin/calibredb
CAL_OPT="list --fields=authors,title"
export LANG=en_US.UTF-8

#
# list the main library
#
${CALIBREDB} ${CAL_OPT} --with-library=${LIBNAME} 

