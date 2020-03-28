#!/bin/bash
# try out new toolchain
source $(pwd)/functions.sh

clear && echo $0 $@

baseFolder=$(pwd)
cd ~/mpv-winbuild-cmake/

#set -x #echo on

#cp -v ${baseFolder}/mingw-w64-*.patch toolchain
#add_option toolchain/mingw-w64 "UPDATE_COMMAND \"\"" "PATCH_COMMAND patch -p1 -i \${CMAKE_CURRENT_SOURCE_DIR}/mingw-w64-headers-KScategories.patch"
#comment_line toolchain/mingw-w64.cmake "GIT_TAG 5c8702bbb0228313e74618dac943682b95a4ce17"

#sed -i "s/binutils-2.35.2.tar.xz/binutils-2.37.tar.xz/" toolchain/binutils.cmake
#sed -i "s/9974ede5978d32e0d68fef23da48fa00bd06b0bff7ec45b00ca075c126d6bbe0cf2defc03ecc3f17bc6cc85b64271a13009c4049d7ba17de26e84e3a6e2c0348/5c11aeef6935860a6819ed3a3c93371f052e52b4bdc5033da36037c1544d013b7f12cb8d561ec954fe7469a68f1b66f1a3cd53d5a3af7293635a90d69edd15e7/" toolchain/binutils.cmake

#sed -i "s/GIT_TAG f3855e2caa576b1a6288129f8f99a56d2ef969dd/86d7b3f7b40b806f0b30d216b3cd187732063f8f/" toolchain/mingw-w64.cmake
#add_option toolchain/mingw-w64 "GIT_REPOSITORY https:\/\/github.com\/mirror\/mingw-w64.git" "GIT_TAG 86d7b3f7b40b806f0b30d216b3cd187732063f8f"

#gcc v11
#replace_option gcc-base "11-20211127" "11-20220101"
#replace_option gcc-base "ba0dad9073cd16fdaad5cc05c8ee637fa89f20dca4b0cdf256487e54fa6b88a5a759ae851b946e2122c60f28d295a4ee47bcca3dbcaedcb53bd8a66edd0f5b45" \
#								"33ae3f00c48e19659b9fc26e2dd2ccf98d52babd97c4fc2bf02171507572e1324892699b80e9c5036daec1453b04fc431366317c0456a3a2f59465a2374182a4"
								
#sed -i "s/11-20211127/11-20220101/g" toolchain/gcc-base.cmake
#sed -i "s/ba0dad9073cd16fdaad5cc05c8ee637fa89f20dca4b0cdf256487e54fa6b88a5a759ae851b946e2122c60f28d295a4ee47bcca3dbcaedcb53bd8a66edd0f5b45/33ae3f00c48e19659b9fc26e2dd2ccf98d52babd97c4fc2bf02171507572e1324892699b80e9c5036daec1453b04fc431366317c0456a3a2f59465a2374182a4/" toolchain/gcc-base.cmake

#sed -i "s/11-20211127/11-20211225/g" toolchain/gcc-base.cmake
#sed -i "s/ba0dad9073cd16fdaad5cc05c8ee637fa89f20dca4b0cdf256487e54fa6b88a5a759ae851b946e2122c60f28d295a4ee47bcca3dbcaedcb53bd8a66edd0f5b45/3769253f661c3d9e69479ac9d2690a1abfe4b34bfa95ba19e05f2dacfa44a8ae612c81d5e49b7720bce7fd2781802d19adeea9b10b5248c164b52af505375f45/" toolchain/gcc-base.cmake

#sed -i "s/10-20210130/11.2-RC-20210721/g" toolchain/gcc-base.cmake
#sed -i "s/e6092eddc5feaef49bc86e800617f0475e7877ab61ae85b5c610c57e4a591939e54fdfc305c8b9438a4d2ee1fecee84c19123635f43aeaf9641806fcc4cef3ef/b4d67460267d284ceaa5fb1044ab3553cbfd3b7b30842312f0777057e14548eac80d4f7378a797b2093fe120a69852c1f293e09de3c56caca5f412efb8523df0/" toolchain/gcc-base.cmake
