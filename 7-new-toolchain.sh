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

replace_option gcc "13-20230610" "13-20230722"
replace_option gcc "a2e00bb5d816d37ea38de7662bb26616603b14cf08bc3452f39300fc8efed3fad372f7603deb36e0e6dd06f082c815997ba22c2b7438e379e782682e6333578d" \
						 "ca832704a36fb29fddb5a8080dfcb77c5018ad01d763842a56119280c07413527173974efae967d2414621aa11154c93eacae102d10388c9a13cc3b86a0e8b82"

#comment_line gcc "PATCH_COMMAND "

#replace_option gcc "13-20230610" "13-20230715"
#replace_option gcc "a2e00bb5d816d37ea38de7662bb26616603b14cf08bc3452f39300fc8efed3fad372f7603deb36e0e6dd06f082c815997ba22c2b7438e379e782682e6333578d" \
#						 "8fb6e33644b9bd991daa7f86359ca67a0b89c2093ea1e194c30e82d2eead87e5b26bfe798ef822cc057d0384eee4cf57a6dedc2c2cd27cff945ee74f2195407f"

#add_option gcc "CONFIGURE_COMMAND " "PATCH_COMMAND \$\{EXEC\} curl -sL https://salsa.debian.org/mingw-w64-team/gcc-mingw-w64/-/raw/5e7d749d80e47d08e34a17971479d06cd423611e/debian/patches/vmov-alignment.patch | patch -p2"

#replace_option binutils "2.39" "2.40"
#replace_option binutils "68e038f339a8c21faa19a57bbc447a51c817f47c2e06d740847c6e9cc3396c025d35d5369fa8c3f8b70414757c89f0e577939ddc0d70f283182504920f53b0a3" \
#						 "a37e042523bc46494d99d5637c3f3d8f9956d9477b748b3b1f6d7dfbb8d968ed52c932e88a4e946c6f77b8f48f1e1b360ca54c3d298f17193f3b4963472f6925"


#https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/?C=M;O=D
if ! curl --output /dev/null --silent --head --fail "https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/13-20230610/gcc-13-20230610.tar.xz"; then
	replace_option gcc "mirrorservice.org\/sites\/sourceware.org\/pub" "bigsearcher.com\/mirrors"
fi
