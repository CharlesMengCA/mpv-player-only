#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

echo_info  $0 $@

toolchain="gcc-"$(find ~/mpv-winbuild-cmake/src_packages/gcc -maxdepth 1 -name *.xz  -printf "%f\n" | sed 's/gcc-\(.*\)\..*\..*/\1/')
#[[ $toolchain == "gcc-" ]] && toolchain="clang-"$($HOME/mpv-winbuild-cmake/clang_root/bin/llvm-ar --version | sed -n 's/.*version \(.*\)/\1/p')
[[ $toolchain == "gcc-" ]] && toolchain="clang-"$(cd ~/mpv-winbuild-cmake/src_packages/llvm && git describe | sed 's/[^-]*-\([^-]*\)/\1/' | sed 's/\([^-]*\)-.*/\1/')

mpv_build=$(find ~/mpv-winbuild-cmake/build64 -maxdepth 1 -type d -name mpv-x86_64-*-git*)

target_folder="$HOME/mpv/Mod/$(basename $mpv_build)_$toolchain"

[[ -d "$target_folder" && ! -L "$target_folder" ]] && echo "FOLDER EXISTS: $target_folder" && exit

cp -R --preserve=timestamps $mpv_build $target_folder

mpv_dev=$(find ~/mpv-winbuild-cmake/build64/ -maxdepth 1 -type d -name mpv-dev-x86_64-*-git-*)

cp -R --preserve=timestamps $mpv_dev/* $target_folder

echo $target_folder
ls -g -o --group-directories-first --time-style=iso $target_folder

#--color=auto