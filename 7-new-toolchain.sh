#!/bin/bash
# try out new toolchain
source $(pwd)/functions.sh

clear && echo $0 $@

baseFolder=$(pwd)
cd ~/mpv-winbuild-cmake/

#set -x #echo on

#replace_option mingw-w64 "mirror" "mingw-w64"
#append_option mingw-w64 "GIT_REPOSITORY https:\/\/github.com\/mirror\/mingw-w64.git" "GIT_TAG origin/v11.x"

#gcc v12
#replace_option gcc "releases\/gcc-12.2.0\/gcc-12.2.0" "snapshots\/12-20220917\/gcc-12-20220917"

#replace_option gcc "12-20230401" "13-20230610"
#replace_option gcc "b0757f56cd778ca537090c79d1ca606e28d258473a9add59df9be39dcfe3047cbe324e81a389f101d8ded31419b0e535410997593bd99a6fa22730288362de4e" \
#						 "a2e00bb5d816d37ea38de7662bb26616603b14cf08bc3452f39300fc8efed3fad372f7603deb36e0e6dd06f082c815997ba22c2b7438e379e782682e6333578d"

#comment_line gcc "PATCH_COMMAND "

replace_option gcc "12-20230401" "12-20230609"
replace_option gcc "b0757f56cd778ca537090c79d1ca606e28d258473a9add59df9be39dcfe3047cbe324e81a389f101d8ded31419b0e535410997593bd99a6fa22730288362de4e" \
						 "6d3d3bb57ee15583a65b85808172b57e6c3d7715aaf27ec22cd6f12e764d57a2cf4334b1ca9eae51737af930027110eba0bb3fb8a0a3c965336d716503c08d69"

#replace_option binutils "2.39" "2.40"
#replace_option binutils "68e038f339a8c21faa19a57bbc447a51c817f47c2e06d740847c6e9cc3396c025d35d5369fa8c3f8b70414757c89f0e577939ddc0d70f283182504920f53b0a3" \
#						 "a37e042523bc46494d99d5637c3f3d8f9956d9477b748b3b1f6d7dfbb8d968ed52c932e88a4e946c6f77b8f48f1e1b360ca54c3d298f17193f3b4963472f6925"


#https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/?C=M;O=D
if ! curl --output /dev/null --silent --head --fail "https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/12-20230401/gcc-12-20230401.tar.xz"; then
	replace_option gcc "mirrorservice.org\/sites\/sourceware.org\/pub" "bigsearcher.com\/mirrors"
fi
