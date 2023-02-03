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
replace_option gcc "12-20230121" "12-20230128"
replace_option gcc "b6c2486916418a64fab64c3655329bc18ca93ee4eca240e8779bd6d8280124fcd07b1aa8eff979fd317656646ecdba9353107887338354d8bd2c1f68c1609349" \
						 "7086b66509a9f7080805d9c4f8abf463c8e37729158eb2da60d9de97f9cdfd8664fe481a75c3730b78e12812bc9711c29554370f1af227c664ee6d3cf8708ede"

#replace_option gcc "12-20230121" "12-20230121"
#replace_option gcc "b6c2486916418a64fab64c3655329bc18ca93ee4eca240e8779bd6d8280124fcd07b1aa8eff979fd317656646ecdba9353107887338354d8bd2c1f68c1609349" \
#						 "b6c2486916418a64fab64c3655329bc18ca93ee4eca240e8779bd6d8280124fcd07b1aa8eff979fd317656646ecdba9353107887338354d8bd2c1f68c1609349"

#replace_option binutils "2.39" "2.40"
#replace_option binutils "68e038f339a8c21faa19a57bbc447a51c817f47c2e06d740847c6e9cc3396c025d35d5369fa8c3f8b70414757c89f0e577939ddc0d70f283182504920f53b0a3" \
#						 "a37e042523bc46494d99d5637c3f3d8f9956d9477b748b3b1f6d7dfbb8d968ed52c932e88a4e946c6f77b8f48f1e1b360ca54c3d298f17193f3b4963472f6925"



if ! curl --output /dev/null --silent --head --fail "https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/12-20221022/gcc-12-20221022.tar.xz"; then
	replace_option gcc "mirrorservice.org\/sites\/sourceware.org\/pub" "bigsearcher.com\/mirrors"
fi
