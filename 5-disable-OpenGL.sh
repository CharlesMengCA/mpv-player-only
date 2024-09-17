#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

[[ $1 == "" ]] && clear
echo_info $0 $@

cd ~/mpv-winbuild-cmake/

# libepoxy
#comment_line CMakeLists.txt "libepoxy"
#comment_line libplacebo "libepoxy"

# gl
append_option libplacebo "-Ddemos=false" "-Dopengl=disabled"
comment_line ffmpeg "--enable-opengl"

replace_option mpv "\${mpv_gl}" "-Dgl=disabled -Degl-angle=disabled"

comment_line mpv "-Dc_args='-Wno-error=int-conversion'"
