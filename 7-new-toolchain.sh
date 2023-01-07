#!/bin/bash
# try out new toolchain
source $(pwd)/functions.sh

clear && echo $0 $@

baseFolder=$(pwd)
cd ~/mpv-winbuild-cmake/

#set -x #echo on

#append_option mingw-w64 "GIT_REPOSITORY https:\/\/github.com\/mirror\/mingw-w64.git" "GIT_TAG 09a6458131cda15b85cabd4a380dd5426deb7943"

#gcc v12
#replace_option gcc "releases\/gcc-12.2.0\/gcc-12.2.0" "snapshots\/12-20220917\/gcc-12-20220917"
replace_option gcc "12-20221217" "12-20221231"
replace_option gcc "64a0f8f9b8ea07b1dcd0807c4fdae9de5cb0f1986c02a81798a47a116539695ce2408bdcea723ac55d892ccc0435319e7e7f4e472f2692407a77205669563d67" \
						 "76fc6bd5b1e7711e4f2f7c391bc057a3c64db193af11cd2edb7bde5a638134aaac37012da75b90aea30da04b69565276f377266318471b4d123252cf3e5f5852"


if ! curl --output /dev/null --silent --head --fail "https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/12-20221022/gcc-12-20221022.tar.xz"; then
	replace_option gcc "mirrorservice.org\/sites\/sourceware.org\/pub" "bigsearcher.com\/mirrors"
fi
