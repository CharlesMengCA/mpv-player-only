#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

# try out new toolchain

echo_info $0 $@

cd ~/mpv-winbuild-cmake/

#set -x #echo on

#replace_option mingw-w64 "mirror" "mingw-w64"
#append_option mingw-w64 "GIT_REPOSITORY https:\/\/github.com\/mirror\/mingw-w64.git" "GIT_TAG origin/v11.x"

replace_option gcc "14-20240914" "14-20241026"
replace_option gcc "9f63ebf77a1fc18fe71681e1f97d667c077c87342bbf892510796cb6c0988c4cc2d99a5f6cbb46a10d4280012cc519604e1331648e2bba9449b6d5be580a1bf8" \
						 "18ff215b02e18ea7d49fad5437a7e65166278ea78b35499d4402569c18790d334df9c0b54664460182f74bffa92b7faaa71728956e1d5e1c7be57f8a1045fb7f"

#replace_option llvm "GIT_TAG release\/18.x" "GIT_TAG release\/19.x"


#replace_option gcc/gcc "14-20240914" "14-20240914"
#replace_option gcc/gcc "9f63ebf77a1fc18fe71681e1f97d667c077c87342bbf892510796cb6c0988c4cc2d99a5f6cbb46a10d4280012cc519604e1331648e2bba9449b6d5be580a1bf8" \
#						 "d8d757cfbedb7342443ce8de4439653537c46d25e552d88cea0ba9f7aa43ad14fb2b42a32a1dce5ae4eb2ac3849024f6b4e700f2c39330a00a65caa3f5fe29e7"

#comment_line gcc "PATCH_COMMAND "

#add_option gcc "CONFIGURE_COMMAND " "PATCH_COMMAND \$\{EXEC\} curl -sL https://salsa.debian.org/mingw-w64-team/gcc-mingw-w64/-/raw/5e7d749d80e47d08e34a17971479d06cd423611e/debian/patches/vmov-alignment.patch | patch -p2"

#replace_option binutils "2.39" "2.40"
#replace_option binutils "68e038f339a8c21faa19a57bbc447a51c817f47c2e06d740847c6e9cc3396c025d35d5369fa8c3f8b70414757c89f0e577939ddc0d70f283182504920f53b0a3" \
#						 "a37e042523bc46494d99d5637c3f3d8f9956d9477b748b3b1f6d7dfbb8d968ed52c932e88a4e946c6f77b8f48f1e1b360ca54c3d298f17193f3b4963472f6925"

#https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/?C=M;O=D
if ! curl --output /dev/null --silent --head --fail "https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/13-20240309/gcc-13-20240309.tar.xz"; then
	replace_option gcc "mirrorservice.org\/sites\/sourceware.org\/pub" "bigsearcher.com\/mirrors"
fi
