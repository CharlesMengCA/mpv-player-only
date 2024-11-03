#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

echo 'Start: ' $(date '+%H:%M:%S') > $HOME/build_time.txt

cd $HOME/mpv-winbuild-cmake/build64

rm -rf mpv-*

if [[ $1 == "all" || $2 == "all" ]]; then
   rm -rf ../src_packages/*
   rm -rf packages/*
else
  ninja ffmepg-fullclean
  ninja mpv-fullclean

  ninja ffmepg-forceupdate
  ninja mpv-forceupdate
fi

ninja mpv

cd mpv-x86_64* && ls -g -o --time-style=iso *.exe
cd ../mpv-dev-x86_64-* && ls -g -o --time-style=iso *.dll

echo 'Done: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt
