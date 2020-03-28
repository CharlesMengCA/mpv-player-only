#!/bin/bash
echo $0 $@

sed -i -e 's/$(git describe \\/$(git describe)"/' version.sh
sed -i -e '/\-\-always \-\-tags \-\-dirty/d' version.sh
sed -i -e 's/2021/$(date +"%Y")/g' version.sh
sed -i -e 's/version="$git_revision"/version="$git_revision"\n[ ${version: -1} == "4" ] \&\& version="${git_revision:0:-1}"8/' version.sh

sed -i -e 's/" ".join(argv)/" ".join(argv).replace("\/root\/mpv-winbuild-cmake\/build64\/packages\/mpv-prefix\/src\/mpv\/waf configure ","").replace("--disable-debug-build ","").replace("--disable-manpage-build ","").replace("--enable-static-build ","").replace("--enable-libmpv-shared ","").replace(" --prefix=\/root\/mpv-winbuild-cmake\/build64\/install\/mingw","")/' waftools/generators/headers.py

cd player/lua

sed -i -e '/\-\-\[\[/,/\-\-\]\]/{d}' *.lua
sed -i -e '/^\s*--/{d}' *.lua
sed -i -e 's/\s\+--.*$//' *.lua
sed -i -e 's/\-\- bar, line, slider, inverted or none//' *.lua

#git commit -a -m 'remove lua comments'
