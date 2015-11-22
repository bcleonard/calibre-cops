#!/bin/sh

LIBNAME=/data/library
CALIBREDB=/usr/bin/calibredb
CAL_OPT="remove"
export LANG=en_US.UTF-8

OPTIND=1

if [ $# -ne 2 ]
then
  echo ""
  echo "usage: ${0} -i book_id_to_remove"
  echo ""
  exit 1
fi

#
# process command line arguments
#
while getopts "i:" opt
do
  case ${opt} in
    i)  id=${OPTARG}
        ;;
    esac
done
#
# remove books from the library
#
${CALIBREDB} ${CAL_OPT} ${id} --with-library=${LIBNAME} 

