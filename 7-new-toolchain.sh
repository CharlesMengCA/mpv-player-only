#!/bin/bash
# try out new toolchain
source $(pwd)/functions.sh

clear && echo $0 $@

baseFolder=$(pwd)
cd ~/mpv-winbuild-cmake/

#set -x #echo on

#append_option mingw-w64 "GIT_REPOSITORY https:\/\/github.com\/mirror\/mingw-w64.git" "GIT_TAG 3d2042584a6c2521fad29a723312d095e0c75006"

#gcc v12
replace_option gcc "releases\/gcc-12.2.0\/gcc-12.2.0" "snapshots\/12-20220910\/gcc-12-20220910"
#replace_option gcc "12-20220702" "12.2.0-RC-20220812"
replace_option gcc "e9e857bd81bf7a370307d6848c81b2f5403db8c7b5207f54bce3f3faac3bde63445684092c2bc1a2427cddb6f7746496d9fbbef05fbbd77f2810b2998f1f9173" \
						 "6123d2dbd2f6fd68b050d2356278ecf801aae902a780c0953a0fb418baa34ee0eace6c9b037009c12ec75f42b37cc29e0c2ca3d706b07b9bd1b4f70579104dc3"
