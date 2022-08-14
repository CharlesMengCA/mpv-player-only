#!/bin/bash
# try out new toolchain
source $(pwd)/functions.sh

clear && echo $0 $@

baseFolder=$(pwd)
cd ~/mpv-winbuild-cmake/

#set -x #echo on

#append_option mingw-w64 "GIT_REPOSITORY https:\/\/github.com\/mirror\/mingw-w64.git" "GIT_TAG 3d2042584a6c2521fad29a723312d095e0c75006"

#gcc v12
#replace_option gcc "releases\/gcc-12.1.0\/gcc-12.1.0" "snapshots\/12-20220702\/gcc-12-20220702"
replace_option gcc "12-20220702" "12.2.0-RC-20220812"
replace_option gcc "e5ab44e79f641ace6d9d77ffb176f3309d35e8f36b6bdd42f09e29fcc82766933e0fb8f86be84bf7419fe9918c554544d34c448b706ec0cb052e738e5594683c" \
						 "74d6f7c9cb1070920ae85533b6db986c3a784f74a3f5eac113c483230b78737c33bc6f10a2221ace7f9c8af0e3824390241da73d367dd77e5832205a47a47940"
