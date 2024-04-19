#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

# try out new toolchain

clear && echo $0 $@
cd ~/mpv-winbuild-cmake/

#set -x #echo on

#replace_option mingw-w64 "mirror" "mingw-w64"
#append_option mingw-w64 "GIT_REPOSITORY https:\/\/github.com\/mirror\/mingw-w64.git" "GIT_TAG origin/v11.x"

#replace_option gcc "snapshots\/13-20230610\/gcc-13-20230610" "releases\/gcc-13.2.0\/gcc-13.2.0"
#replace_option gcc "6f62981040894fdc98fff57295608092b917fe909cd67477c9ffc81197e5780ebabe1fbb4113e792ea441e0adb79fec5f802cda807632945c36ea295d623f19f" \
#						 "d99e4826a70db04504467e349e9fbaedaa5870766cda7c5cab50cdebedc4be755ebca5b789e1232a34a20be1a0b60097de9280efe47bdb71c73251e30b0862a2"

replace_option gcc/gcc "13-20240309" "13-20230429"
replace_option gcc/gcc "2d1e0374ebdee526f0549319fc9c364968c52a0d4aaa16759f00453cb083fe58d8f463c47d97f3bb74a0a92e251989eb75a50ee5800b4569978c72d25446b44e" \
                       "48095ff181f7389bda249dcd67c3c0369dd8fbe4741a8ab00833c0f5d569be165db28c369f65960650812a6011dda21692cca806f4c3261773b28d702e9f0c53"

#comment_line gcc "PATCH_COMMAND "

#replace_option gcc/gcc "13-20240309" "13-20231021"
#replace_option gcc/gcc "2d1e0374ebdee526f0549319fc9c364968c52a0d4aaa16759f00453cb083fe58d8f463c47d97f3bb74a0a92e251989eb75a50ee5800b4569978c72d25446b44e" \
#						 "f713492b0a92d3cd61e0f4d1ed8cdd70e5be7fb77df1ade54e760e800f213a7e6004cc7bdb338dffbd0b768f4c39a88d6b45e86b957f3ff689f2abf5c39686b1"

#add_option gcc "CONFIGURE_COMMAND " "PATCH_COMMAND \$\{EXEC\} curl -sL https://salsa.debian.org/mingw-w64-team/gcc-mingw-w64/-/raw/5e7d749d80e47d08e34a17971479d06cd423611e/debian/patches/vmov-alignment.patch | patch -p2"

#replace_option binutils "2.39" "2.40"
#replace_option binutils "68e038f339a8c21faa19a57bbc447a51c817f47c2e06d740847c6e9cc3396c025d35d5369fa8c3f8b70414757c89f0e577939ddc0d70f283182504920f53b0a3" \
#						 "a37e042523bc46494d99d5637c3f3d8f9956d9477b748b3b1f6d7dfbb8d968ed52c932e88a4e946c6f77b8f48f1e1b360ca54c3d298f17193f3b4963472f6925"

#https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/?C=M;O=D
if ! curl --output /dev/null --silent --head --fail "https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/13-20240309/gcc-13-20240309.tar.xz"; then
	replace_option gcc "mirrorservice.org\/sites\/sourceware.org\/pub" "bigsearcher.com\/mirrors"
fi
