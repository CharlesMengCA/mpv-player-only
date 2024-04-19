#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

#if [[ $(pwd) == *"src_packages"* ]]; then
   PKG_NAME=${PWD##*/}
#else
#   PKG_NAME=$(pwd | sed 's/^.*packages\/\(.*\)-.*$/\1/')
#fi

PATCH_PATTERN=$SCRIPT_DIR"/"$PKG_NAME"*.patch"
PATCH_COUNT=$(ls $PATCH_PATTERN | wc -l)

[ $PATCH_COUNT -eq 0 ] && exit

echo "git apply $PATCH_PATTERN"

git apply $PATCH_PATTERN

git status -s
#git log -n 1 --oneline
