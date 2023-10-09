#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

clear && echo $0 $@

cd ~/mpv-winbuild-cmake/

# libepoxy
#comment_line CMakeLists.txt "libepoxy"
#comment_line libplacebo "libepoxy"

# gl
append_option libplacebo "-Ddemos=false" "-Dopengl=disabled"
append_option mpv "-Dvulkan=enabled" "-Dgl=disabled"

replace_option mpv "-Degl-angle=enabled" "-Degl-angle=disabled"
