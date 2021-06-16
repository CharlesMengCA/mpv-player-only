#!/bin/bash
clear
echo $0 $@

comment_line () {
	sed -i "/^\s*$1/s/^/#/g" packages/CMakeLists.txt	
}

cd ~/mpv-winbuild-cmake/

set -x #echo on

comment_line termcap
comment_line readline
comment_line cryptopp
comment_line sqlite
comment_line libuv
comment_line libsodium
comment_line megasdk

