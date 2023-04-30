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

#replace_option gcc "12-20230401" "12-20230421"
#replace_option gcc "b0757f56cd778ca537090c79d1ca606e28d258473a9add59df9be39dcfe3047cbe324e81a389f101d8ded31419b0e535410997593bd99a6fa22730288362de4e" \
#						 "140ff8e4f387284e070b22f22e51f3aa09ada233dc2bca90894f4b0dbd3e9532f266c8606bea6152afed3eedb853548247f133e332e23f7c6bf380fa61b54b96"

replace_option gcc "12-20230401" "12-20230428"
replace_option gcc "b0757f56cd778ca537090c79d1ca606e28d258473a9add59df9be39dcfe3047cbe324e81a389f101d8ded31419b0e535410997593bd99a6fa22730288362de4e" \
						 "992f9cd71f9910efea401048540ba2b43360170f76ce992cf356b1ab383240f481e29c5b0ad32fa4efb2bdbb397477506cb83a825268cfbdd2cde7044d43c758"

#replace_option binutils "2.39" "2.40"
#replace_option binutils "68e038f339a8c21faa19a57bbc447a51c817f47c2e06d740847c6e9cc3396c025d35d5369fa8c3f8b70414757c89f0e577939ddc0d70f283182504920f53b0a3" \
#						 "a37e042523bc46494d99d5637c3f3d8f9956d9477b748b3b1f6d7dfbb8d968ed52c932e88a4e946c6f77b8f48f1e1b360ca54c3d298f17193f3b4963472f6925"


#https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/?C=M;O=D
if ! curl --output /dev/null --silent --head --fail "https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/12-20230218/gcc-12-20230218.tar.xz"; then
	replace_option gcc "mirrorservice.org\/sites\/sourceware.org\/pub" "bigsearcher.com\/mirrors"
fi
