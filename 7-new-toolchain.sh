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

replace_option gcc "12-20230401" "13-20230520"
replace_option gcc "b0757f56cd778ca537090c79d1ca606e28d258473a9add59df9be39dcfe3047cbe324e81a389f101d8ded31419b0e535410997593bd99a6fa22730288362de4e" \
						 "d6c8626822855f71cc58b6b36ebb38092aaf12fa9aa40b8d70fb3edc9f4c614fbf47626ea5cc1ec631bc47b5d64911bfdb7cfc6924f27a54016b1f8c9c7588d7"

comment_line gcc "PATCH_COMMAND "

#replace_option gcc "12-20230401" "12-20230519"
#replace_option gcc "b0757f56cd778ca537090c79d1ca606e28d258473a9add59df9be39dcfe3047cbe324e81a389f101d8ded31419b0e535410997593bd99a6fa22730288362de4e" \
#						 "cd24ad69a6c47a95384d8fd4fcb7e895f8fb4d8e0c4b74d1300943fa8198624e3c40b0bd7702cb78f40849a09b5069e50e36bc191bd206b36c956ca25126ee02"

#replace_option binutils "2.39" "2.40"
#replace_option binutils "68e038f339a8c21faa19a57bbc447a51c817f47c2e06d740847c6e9cc3396c025d35d5369fa8c3f8b70414757c89f0e577939ddc0d70f283182504920f53b0a3" \
#						 "a37e042523bc46494d99d5637c3f3d8f9956d9477b748b3b1f6d7dfbb8d968ed52c932e88a4e946c6f77b8f48f1e1b360ca54c3d298f17193f3b4963472f6925"


#https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/?C=M;O=D
if ! curl --output /dev/null --silent --head --fail "https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/12-20230401/gcc-12-20230401.tar.xz"; then
	replace_option gcc "mirrorservice.org\/sites\/sourceware.org\/pub" "bigsearcher.com\/mirrors"
fi
