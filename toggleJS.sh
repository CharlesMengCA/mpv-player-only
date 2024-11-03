#!/bin/bash
source $(pwd)/functions.sh

cd ~/mpv-winbuild-cmake/

if [[ $1 == "on" || $1 == "off" ]]; then
   js=$1
elif grep -A0 "Djavascript=enabled" packages/mpv.cmake >/dev/null; then
   js="off"
else
   js="on"
fi

if [[ $js == "on" ]]; then
   uncomment_line mpv "mujs"
   replace_option mpv "-Djavascript=disabled" "-Djavascript=enabled"
   echo "javascript: enabled" >> $HOME/build_time.txt
else
   comment_line mpv "mujs"
   replace_option mpv "-Djavascript=enabled" "-Djavascript=disabled"
   echo "javascript: disabled" >> $HOME/build_time.txt
fi
