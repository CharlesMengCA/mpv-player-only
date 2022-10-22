#!/bin/bash
source $(pwd)/functions.sh
clear && echo $0 $@

mpv_build=$(find ~/mpv-winbuild-cmake/build64 -maxdepth 1 -type d -name mpv-x86_64-*-git*)
cp -R --preserve=timestamps $mpv_build ~/mpv/Mod/

mpv_dev=$(find ~/mpv-winbuild-cmake/build64/ -maxdepth 1 -type d -name mpv-dev-x86_64-*-git-*)
mpv_build=$(basename $mpv_build)
cp -R --preserve=timestamps $mpv_dev/* ~/mpv/Mod/$mpv_build

echo ~/mpv/Mod/$mpv_build
ls -g -o --group-directories-first --time-style=iso ~/mpv/Mod/$mpv_build

#--color=auto