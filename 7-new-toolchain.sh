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

#replace_option gcc "snapshots\/13-20230610\/gcc-13-20230610" "releases\/gcc-13.2.0\/gcc-13.2.0"
#replace_option gcc "46a42d79de118a16dc195605fd461034e9b41856fb11fee3bcce962517e713094935704aa88e1ca05f896176bee9eecfef835ee8858ea584421b924390fe3812" \
#						 "d99e4826a70db04504467e349e9fbaedaa5870766cda7c5cab50cdebedc4be755ebca5b789e1232a34a20be1a0b60097de9280efe47bdb71c73251e30b0862a2"

replace_option gcc "13-20230729" "13-20230902"
replace_option gcc "46a42d79de118a16dc195605fd461034e9b41856fb11fee3bcce962517e713094935704aa88e1ca05f896176bee9eecfef835ee8858ea584421b924390fe3812" \
						 "81aff20ced3d973183a214d6936662c32b76edaa72fe6d12849ced988acb1aab78a013e6050e6b79a845fabb08486b552ec2e61826d52abc053bb6aeb571b5e9"

#comment_line gcc "PATCH_COMMAND "

#replace_option gcc "13-20230729" "13-20230826"
#replace_option gcc "46a42d79de118a16dc195605fd461034e9b41856fb11fee3bcce962517e713094935704aa88e1ca05f896176bee9eecfef835ee8858ea584421b924390fe3812" \
#						 "3d47632e90651bd50a881c727c1ef2aa3322b4fc3e082919ae430270901abf8a05a34fe93f8b678c10dc9a0758f93dc3b33ed5947c8743dab453d2b50c063722"

#add_option gcc "CONFIGURE_COMMAND " "PATCH_COMMAND \$\{EXEC\} curl -sL https://salsa.debian.org/mingw-w64-team/gcc-mingw-w64/-/raw/5e7d749d80e47d08e34a17971479d06cd423611e/debian/patches/vmov-alignment.patch | patch -p2"

#replace_option binutils "2.39" "2.40"
#replace_option binutils "68e038f339a8c21faa19a57bbc447a51c817f47c2e06d740847c6e9cc3396c025d35d5369fa8c3f8b70414757c89f0e577939ddc0d70f283182504920f53b0a3" \
#						 "a37e042523bc46494d99d5637c3f3d8f9956d9477b748b3b1f6d7dfbb8d968ed52c932e88a4e946c6f77b8f48f1e1b360ca54c3d298f17193f3b4963472f6925"


#https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/?C=M;O=D
if ! curl --output /dev/null --silent --head --fail "https://mirrorservice.org/sites/sourceware.org/pub/gcc/snapshots/13-20230610/gcc-13-20230610.tar.xz"; then
	replace_option gcc "mirrorservice.org\/sites\/sourceware.org\/pub" "bigsearcher.com\/mirrors"
fi
