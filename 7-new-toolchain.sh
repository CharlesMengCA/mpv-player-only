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
replace_option gcc "12-20221022" "12-20221217"
replace_option gcc "6b8a11b605ec75d6623d6072ad57d59865168da97ab0385506c8e5092bcc14473fbdd35177e79746efbaaffa44e45b93c4adad11c08f34e6d1935e74d3c1c75d" \
						 "64a0f8f9b8ea07b1dcd0807c4fdae9de5cb0f1986c02a81798a47a116539695ce2408bdcea723ac55d892ccc0435319e7e7f4e472f2692407a77205669563d67"

#replace_option gcc "12-20221022" "12-20221210"
#replace_option gcc "6b8a11b605ec75d6623d6072ad57d59865168da97ab0385506c8e5092bcc14473fbdd35177e79746efbaaffa44e45b93c4adad11c08f34e6d1935e74d3c1c75d" \
#						 "00399148932b5c57dbe442dcde01e856cbb981c7cc6703760ea51b28e0784cbc6e016663f195b69714da8c7e2cdcfbc03cb1939bab3e6b507b64846e1e814fa6"

if ! curl --output /dev/null --silent --head --fail "https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/12-20221022/gcc-12-20221022.tar.xz"; then
	replace_option gcc "mirrorservice.org\/sites\/sourceware.org\/pub" "bigsearcher.com\/mirrors"
fi
