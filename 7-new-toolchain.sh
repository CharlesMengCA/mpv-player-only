#!/bin/bash
# try out new toolchain
source $(pwd)/functions.sh

clear && echo $0 $@

baseFolder=$(pwd)
cd ~/mpv-winbuild-cmake/

#set -x #echo on

#append_option mingw-w64 "GIT_REPOSITORY https:\/\/github.com\/mirror\/mingw-w64.git" "GIT_TAG 3d2042584a6c2521fad29a723312d095e0c75006"

#gcc v12
#replace_option gcc "releases\/gcc-12.2.0\/gcc-12.2.0" "snapshots\/12-20220917\/gcc-12-20220917"
replace_option gcc "12-20220924" "12-20221015"
replace_option gcc "ba4d9e73d108088da26fbefe18d9b245b76771ffe752c2b4b31bdf38a2d0b638fbc115c377526c27311d4d7ffd4e0d236a5af5016bd364ccaa11a4989d1401e8" \
						 "6a76d79a95d2826a80c3fbddc0617776964ca8fe65f09ee5706ebc1d92277f695b70d18d165d1964559e8ceb51cebabb7ea4ef464ce0d9d1bb49600c1a429428"

