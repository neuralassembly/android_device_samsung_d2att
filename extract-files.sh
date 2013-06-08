#!/bin/sh

set -e

#if [ $# -eq 0 ]; then
#  SRC=adb
#else
#  if [ $# -eq 1 ]; then
#    SRC=$1
#  else
#    echo "$0: bad number of arguments"
#    echo ""
#    echo "usage: $0 [PATH_TO_EXPANDED_ROM]"
#    echo ""
#    echo "If PATH_TO_EXPANDED_ROM is not specified, blobs will be extracted from"
#    echo "the device using adb pull."
#    exit 1
#  fi
#fi

BASE=../../../vendor/samsung/sc06d/proprietary
rm -rf $BASE/*

for FILE in `egrep -v '(^#|^$)' device-proprietary-files.txt`; do
  echo "Extracting /system/$FILE ..."
  DIR=`dirname $FILE`
  if [ ! -d $BASE/$DIR ]; then
    mkdir -p $BASE/$DIR
  fi

  if [ -f ../../../backup-sc06d/make_JP_CompleteROM_SC06D/diff/system/$FILE ]; then
    cp ../../../backup-sc06d/make_JP_CompleteROM_SC06D/diff/system/$FILE $BASE/$FILE
  else
    if [ -f ../../../backup-sc06d/system/$FILE ]; then
      cp ../../../backup-sc06d/system/$FILE $BASE/$FILE
    fi
  fi
done

for FILE in `egrep -v '(^#|^$)' ../d2-common/common-proprietary-files.txt`; do
  echo "Extracting /system/$FILE ..."
  DIR=`dirname $FILE`
  if [ ! -d $BASE/$DIR ]; then
    mkdir -p $BASE/$DIR
  fi

  if [ -f ../../../backup-sc06d/make_JP_CompleteROM_SC06D/diff/system/$FILE ]; then
    cp ../../../backup-sc06d/make_JP_CompleteROM_SC06D/diff/system/$FILE $BASE/$FILE
  else
    if [ -f ../../../backup-sc06d/system/$FILE ]; then
      cp ../../../backup-sc06d/system/$FILE $BASE/$FILE
    fi
  fi
done

#### apps

for FILE in `egrep -v '(^#|^$)' device-proprietary-apps.txt`; do
  echo "Extracting /system/app/$FILE ..."
  APPDIR=`echo $FILE | sed -e "s/\.[^.]*$//g"`
  if [ ! -d $BASE/$APPDIR ]; then
    mkdir -p $BASE/$APPDIR
  fi

  if [ -f ../../../backup-sc06d/make_JP_CompleteROM_SC06D/diff/system/app/$FILE ]; then
    cp ../../../backup-sc06d/make_JP_CompleteROM_SC06D/diff/system/app/$FILE $BASE/$APPDIR
  fi
done


./setup-makefiles.sh
