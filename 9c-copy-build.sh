#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

clear && echo $0 $@

gcc_version=$(find ~/mpv-winbuild-cmake/src_packages/gcc -maxdepth 1 -name *.xz  -printf "%f\n" | sed 's/gcc-\(.*\)\..*\..*/\1/')
mpv_build=$(find ~/mpv-winbuild-cmake/build64 -maxdepth 1 -type d -name mpv-x86_64-*-git*)
target_folder="$HOME/mpv/Mod/$(basename $mpv_build)_$gcc_version"

[[ -d "$target_folder" && ! -L "$target_folder" ]] && echo "FOLDER EXISTS: $(basename $mpv_build)" && exit

cp -R --preserve=timestamps $mpv_build $target_folder

mpv_dev=$(find ~/mpv-winbuild-cmake/build64/ -maxdepth 1 -type d -name mpv-dev-x86_64-*-git-*)

cp -R --preserve=timestamps $mpv_dev/* $target_folder

echo $target_folder
ls -g -o --group-directories-first --time-style=iso $target_folder

#--color=auto