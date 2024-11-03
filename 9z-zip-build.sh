#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh
clear && echo $0 $@

mkdir ~/out
mpv_build=$(find ~/mpv-winbuild-cmake/build64 -type d -name mpv-x86_64-*-git*)
cp -R --preserve=timestamps $mpv_build ~/out

mpv_dev=$(find ~/mpv-winbuild-cmake/build64/ -type d -name mpv-dev-x86_64-*-git-*)
mpv_build=$(basename $mpv_build)
cp -R --preserve=timestamps $mpv_dev/* ~/out/$mpv_build


echo ~/out/$mpv_build
ls -g -o --group-directories-first --time-style=iso ~/out/$mpv_build
7z a $mpv_build.7z ~/out/$mpv_build -r
#--color=auto