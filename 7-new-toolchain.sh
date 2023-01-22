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
#replace_option gcc "12-20221217" "12-20230107"
#replace_option gcc "64a0f8f9b8ea07b1dcd0807c4fdae9de5cb0f1986c02a81798a47a116539695ce2408bdcea723ac55d892ccc0435319e7e7f4e472f2692407a77205669563d67" \
#						 "79e7caec8fd9fab98df629a70345ca414d29c027afc519a32c4adc8df28c15bb39ec1320a484aa5894d0e4abccd927fa2c5b744f2dc069978322b476fd00e40f"

replace_option gcc "12-20221217" "12-20230121"
replace_option gcc "64a0f8f9b8ea07b1dcd0807c4fdae9de5cb0f1986c02a81798a47a116539695ce2408bdcea723ac55d892ccc0435319e7e7f4e472f2692407a77205669563d67" \
						 "b6c2486916418a64fab64c3655329bc18ca93ee4eca240e8779bd6d8280124fcd07b1aa8eff979fd317656646ecdba9353107887338354d8bd2c1f68c1609349"


if ! curl --output /dev/null --silent --head --fail "https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/12-20221022/gcc-12-20221022.tar.xz"; then
	replace_option gcc "mirrorservice.org\/sites\/sourceware.org\/pub" "bigsearcher.com\/mirrors"
fi
