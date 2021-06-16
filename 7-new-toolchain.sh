#!/bin/bash
clear
echo $0 $@

# some library version may fail during build, find an old version to make it work
add_option () {
  if ! (grep -A1 "$2" $1.cmake | grep -- "$3"); then
   sed -i "/$2/a \    $3" $1.cmake
 fi
}

comment_line () {
	sed -i "/^\s*$2/s/^/#/g" packages/$1
}

cd ~/mpv-winbuild-cmake/

set -x #echo on

#comment_line CMakeLists.txt openal-soft
#comment_line mpv.cmake openal-soft
#comment_line mpv.cmake --enable-openal
#comment_line mpv-stable.cmake openal-soft
#comment_line mpv-stable.cmake --enable-openal


sed -i "s/binutils-2.35.2.tar.xz/binutils-2.36.1.tar.xz/" toolchain/binutils.cmake
sed -i "s/9974ede5978d32e0d68fef23da48fa00bd06b0bff7ec45b00ca075c126d6bbe0cf2defc03ecc3f17bc6cc85b64271a13009c4049d7ba17de26e84e3a6e2c0348/cc24590bcead10b90763386b6f96bb027d7594c659c2d95174a6352e8b98465a50ec3e4088d0da038428abe059bbc4ae5f37b269f31a40fc048072c8a234f4e9/" toolchain/binutils.cmake

sed -i "s/GIT_TAG f3855e2caa576b1a6288129f8f99a56d2ef969dd/GIT_TAG v9.0.0/" toolchain/mingw-w64.cmake

#sed -i "s/20210130/20210430/" toolchain/gcc-base.cmake
#sed -i "s/20210130/20210430/" toolchain/gcc-base.cmake
#sed -i "s/e6092eddc5feaef49bc86e800617f0475e7877ab61ae85b5c610c57e4a591939e54fdfc305c8b9438a4d2ee1fecee84c19123635f43aeaf9641806fcc4cef3ef/087077f82898aa9d052dc2dcf6846bebc586c62e15c31ed315c7f63220f1fb800f1865ff36549854c38e5d4eb6264d80e51e717aca3b06e032836100fe28f585/" toolchain/gcc-base.cmake

#sed -i "s/20210130/20210521/" toolchain/gcc-base.cmake
#sed -i "s/20210130/20210521/" toolchain/gcc-base.cmake
#sed -i "s/e6092eddc5feaef49bc86e800617f0475e7877ab61ae85b5c610c57e4a591939e54fdfc305c8b9438a4d2ee1fecee84c19123635f43aeaf9641806fcc4cef3ef/fb43fab69995a5aedd035198ae77d172dd168d3fe6ac62b6b767112898d63f784da32cd880d23d9991c945be93f38f4ba4399b6f2af777007bacf2b3b079bdac/" toolchain/gcc-base.cmake

#sed -i "s/20210130/20210611/" toolchain/gcc-base.cmake
#sed -i "s/20210130/20210611/" toolchain/gcc-base.cmake
#sed -i "s/e6092eddc5feaef49bc86e800617f0475e7877ab61ae85b5c610c57e4a591939e54fdfc305c8b9438a4d2ee1fecee84c19123635f43aeaf9641806fcc4cef3ef/6a047d05e04545f954099c175e4d4cdd021484a5037b515c7d44177da1afd857b3bebc51f032ff64343c760f83fccfbd7765c97e8ea915a35a323c6949d93300/" toolchain/gcc-base.cmake

#sed -i "s/10-20210130/11-20210426/" toolchain/gcc-base.cmake
#sed -i "s/10-20210130/11-20210426/" toolchain/gcc-base.cmake
#sed -i "s/e6092eddc5feaef49bc86e800617f0475e7877ab61ae85b5c610c57e4a591939e54fdfc305c8b9438a4d2ee1fecee84c19123635f43aeaf9641806fcc4cef3ef/ec8871deee050a1462aeb8371114a4deb950025826749c7704ca00b02e619836ac4ed38c7375e0a5f2ba5f6cd8a181d2ee086234da039023475513a81cb6f386/" toolchain/gcc-base.cmake

sed -i "s/10-20210130/11-20210612/" toolchain/gcc-base.cmake
sed -i "s/10-20210130/11-20210612/" toolchain/gcc-base.cmake
sed -i "s/e6092eddc5feaef49bc86e800617f0475e7877ab61ae85b5c610c57e4a591939e54fdfc305c8b9438a4d2ee1fecee84c19123635f43aeaf9641806fcc4cef3ef/1c60e83cdfbf454c5f245a7a983b4c1ec97dee7caef0d190b11b5e52c8ed819b8e730f327c8cffe56229e38cae1d86e05bde004f1b5bf28911eb6d1388deb280/" toolchain/gcc-base.cmake


