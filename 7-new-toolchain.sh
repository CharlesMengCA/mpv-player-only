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
#replace_option gcc "12-20230218" "12-20230225"
#replace_option gcc "bf2b109a12a981ae97ca4c6d9a27b11adcf1c7acaf167c532936a027dad4217e75b197fd12b2c5e37f6e89fe39a54f483984023accfb76f7517cc3d35ced416a" \
#						 "25889487fe3a03dc4fcce80c6048ef02453aaa0770662b078e1fd4a3c2aaebb8fdf2b77a0898abdb42b2ea1e3ebc03ac720595ddcc22a64a6bf910cf2ece4e16"

replace_option gcc "12-20230218" "12-20230311"
replace_option gcc "bf2b109a12a981ae97ca4c6d9a27b11adcf1c7acaf167c532936a027dad4217e75b197fd12b2c5e37f6e89fe39a54f483984023accfb76f7517cc3d35ced416a" \
						 "e016537c8a06311ccfec5760417f9daa4c4e55b32fc28f32dd0ec7429f53ed753a84a788da304b12f9c7443ec693ad881536cfa875829d201d803138fde59c16"

#replace_option binutils "2.39" "2.40"
#replace_option binutils "68e038f339a8c21faa19a57bbc447a51c817f47c2e06d740847c6e9cc3396c025d35d5369fa8c3f8b70414757c89f0e577939ddc0d70f283182504920f53b0a3" \
#						 "a37e042523bc46494d99d5637c3f3d8f9956d9477b748b3b1f6d7dfbb8d968ed52c932e88a4e946c6f77b8f48f1e1b360ca54c3d298f17193f3b4963472f6925"


#https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/?C=M;O=D
if ! curl --output /dev/null --silent --head --fail "https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/12-20230218/gcc-12-20230218.tar.xz"; then
	replace_option gcc "mirrorservice.org\/sites\/sourceware.org\/pub" "bigsearcher.com\/mirrors"
fi
