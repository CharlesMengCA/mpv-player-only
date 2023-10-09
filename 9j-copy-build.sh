#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

clear && echo $0 $@

mpv_build=$(find ~/mpv-winbuild-cmake/build64 -maxdepth 1 -type d -name mpv-x86_64-*-git*)
target_folder=$(basename $mpv_build)_jxl

mkdir ~/mpv/Mod/$target_folder

cp -R --preserve=timestamps $mpv_build/*.exe ~/mpv/Mod/$target_folder/

mpv_dev=$(find ~/mpv-winbuild-cmake/build64/ -maxdepth 1 -type d -name mpv-dev-x86_64-*-git-*)
cp -R --preserve=timestamps $mpv_dev/*.dll ~/mpv/Mod/$target_folder/

echo ~/mpv/Mod/$target_folder
ls -g -o --group-directories-first --time-style=iso ~/mpv/Mod/$target_folder

#--color=auto