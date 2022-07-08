#!/bin/bash
# try out new toolchain
source $(pwd)/functions.sh

clear && echo $0 $@

baseFolder=$(pwd)
cd ~/mpv-winbuild-cmake/

#set -x #echo on

#append_option mingw-w64 "GIT_REPOSITORY https:\/\/github.com\/mirror\/mingw-w64.git" "GIT_TAG 3d2042584a6c2521fad29a723312d095e0c75006"

#gcc v12
replace_option gcc "releases\/gcc-12.1.0\/gcc-12.1.0" "snapshots\/12-20220702\/gcc-12-20220702"
#replace_option gcc "11-20220429" "12-20220521"
replace_option gcc "2121d295292814a6761edf1fba08c5f633ebe16f52b80e7b73a91050e71e1d2ed98bf17eebad263e191879561c02b48906c53faa4c4670c486a26fc75df23900" \
						 "e5ab44e79f641ace6d9d77ffb176f3309d35e8f36b6bdd42f09e29fcc82766933e0fb8f86be84bf7419fe9918c554544d34c448b706ec0cb052e738e5594683c"
