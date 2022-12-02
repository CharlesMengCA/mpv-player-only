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
#replace_option gcc "12-20221022" "12-20221119"
#replace_option gcc "6b8a11b605ec75d6623d6072ad57d59865168da97ab0385506c8e5092bcc14473fbdd35177e79746efbaaffa44e45b93c4adad11c08f34e6d1935e74d3c1c75d" \
#						 "9ce92bd2042f32d2a650f0e4f102202ff2f6b7592fdeeeabf0c1beb1b9b96312f9cb216b5d912e68bc8ff4c943be03a0fc200fcd00bc4fa210ee8e49e15c2a50"

replace_option gcc "12-20221022" "12-20221126"
replace_option gcc "6b8a11b605ec75d6623d6072ad57d59865168da97ab0385506c8e5092bcc14473fbdd35177e79746efbaaffa44e45b93c4adad11c08f34e6d1935e74d3c1c75d" \
						 "163e0aa39dc5c24980f84000bd6ccd4b7c24581831b7a4cdbd63e4726be5c2b1933d034ce12c65cf95e4c0ebe1175af7e32facace465bfd7c7c377401350a2df"

if ! curl --output /dev/null --silent --head --fail "https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/12-20221022/gcc-12-20221022.tar.xz"; then
	replace_option gcc "mirrorservice.org\/sites\/sourceware.org\/pub" "bigsearcher.com\/mirrors"
fi
