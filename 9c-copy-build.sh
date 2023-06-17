#!/bin/bash
source $(pwd)/functions.sh
clear && echo $0 $@

mpv_build=$(find ~/mpv-winbuild-cmake/build64 -maxdepth 1 -type d -name mpv-x86_64-*-git*)
target_folder="$HOME/mpv/Mod/$(basename $mpv_build)"

[[ -d "$target_folder" && ! -L "$target_folder" ]] && echo "FOLDER EXISTS: $(basename $mpv_build)" && exit

cp -R --preserve=timestamps $mpv_build ~/mpv/Mod/

mpv_dev=$(find ~/mpv-winbuild-cmake/build64/ -maxdepth 1 -type d -name mpv-dev-x86_64-*-git-*)

cp -R --preserve=timestamps $mpv_dev/* $target_folder

echo $target_folder
ls -g -o --group-directories-first --time-style=iso $target_folder

#--color=auto