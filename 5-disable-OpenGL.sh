#!/bin/bash
source $(pwd)/functions.sh

clear && echo $0 $@

cd ~/mpv-winbuild-cmake/

# libepoxy
comment_line CMakeLists.txt "libepoxy"
comment_line libplacebo "libepoxy"

# gl
append_option libplacebo "-Ddemos=false" "-Dopengl=disabled"
append_option mpv "--enable-static-build" "--disable-gl"
