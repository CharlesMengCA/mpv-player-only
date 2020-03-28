#!/bin/bash
source $(pwd)/functions.sh

cd ~/mpv-winbuild-cmake/

if grep -A1 "enable-javascript" packages/mpv.cmake >/dev/null
then
	 comment_line mpv "mujs" 
    replace_option mpv "--enable-javascript" "--disable-javascript" 
else
	 uncomment_line mpv "mujs" 
    replace_option mpv "--disable-javascript" "--enable-javascript"
fi
