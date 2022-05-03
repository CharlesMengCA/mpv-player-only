#!/bin/bash
source $(pwd)/functions.sh

clear && echo $0 $@

cd ~/mpv-winbuild-cmake/

replace_option CMakeLists.txt libressl openssl 
replace_option libsrt libressl openssl
replace_option libssh libressl openssl
replace_option ffmpeg libressl openssl
replace_option ffmpeg --enable-libtls --enable-openssl