#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

# try out new toolchain

clear && echo $0 $@
cd ~/mpv-winbuild-cmake/

#set -x #echo on

#replace_option mingw-w64 "mirror" "mingw-w64"
#append_option mingw-w64 "GIT_REPOSITORY https:\/\/github.com\/mirror\/mingw-w64.git" "GIT_TAG origin/v11.x"

#gcc v12
#replace_option gcc "releases\/gcc-12.2.0\/gcc-12.2.0" "snapshots\/12-20220917\/gcc-12-20220917"

#replace_option gcc "snapshots\/13-20230610\/gcc-13-20230610" "releases\/gcc-13.2.0\/gcc-13.2.0"
#replace_option gcc "a6f8c2482895fb3e5682329c74d40d9c3f5c794e688fbc0a61fe97acacb14dfd03439baec47708eaa46b2ae2c6fcf8c97b5efe6cf89cffc5df74a8427b59fdd1" \
#						 "d99e4826a70db04504467e349e9fbaedaa5870766cda7c5cab50cdebedc4be755ebca5b789e1232a34a20be1a0b60097de9280efe47bdb71c73251e30b0862a2"

#replace_option gcc "13-20230916" "13-20231007"
#replace_option gcc "a6f8c2482895fb3e5682329c74d40d9c3f5c794e688fbc0a61fe97acacb14dfd03439baec47708eaa46b2ae2c6fcf8c97b5efe6cf89cffc5df74a8427b59fdd1" \
#						 "5e3c7f4ec2b1d9f0f65097b0d992bf5acfafb2830b1394a832a4e95163a369b9beb42681cd0fd09aa25494d8b83bc377f1f03f0319dd785d4eea372b8477074b"

#comment_line gcc "PATCH_COMMAND "

replace_option gcc "13-20230916" "13-20231021"
replace_option gcc "a6f8c2482895fb3e5682329c74d40d9c3f5c794e688fbc0a61fe97acacb14dfd03439baec47708eaa46b2ae2c6fcf8c97b5efe6cf89cffc5df74a8427b59fdd1" \
						 "f713492b0a92d3cd61e0f4d1ed8cdd70e5be7fb77df1ade54e760e800f213a7e6004cc7bdb338dffbd0b768f4c39a88d6b45e86b957f3ff689f2abf5c39686b1"

#add_option gcc "CONFIGURE_COMMAND " "PATCH_COMMAND \$\{EXEC\} curl -sL https://salsa.debian.org/mingw-w64-team/gcc-mingw-w64/-/raw/5e7d749d80e47d08e34a17971479d06cd423611e/debian/patches/vmov-alignment.patch | patch -p2"

#replace_option binutils "2.39" "2.40"
#replace_option binutils "68e038f339a8c21faa19a57bbc447a51c817f47c2e06d740847c6e9cc3396c025d35d5369fa8c3f8b70414757c89f0e577939ddc0d70f283182504920f53b0a3" \
#						 "a37e042523bc46494d99d5637c3f3d8f9956d9477b748b3b1f6d7dfbb8d968ed52c932e88a4e946c6f77b8f48f1e1b360ca54c3d298f17193f3b4963472f6925"

#https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/?C=M;O=D
if ! curl --output /dev/null --silent --head --fail "https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/13-20230916/gcc-13-20230916.tar.xz"; then
	replace_option gcc "mirrorservice.org\/sites\/sourceware.org\/pub" "bigsearcher.com\/mirrors"
fi
