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

sed -i "s/binutils-2.35.2.tar.xz/binutils-2.36.1.tar.xz/" toolchain/binutils.cmake
sed -i "s/9974ede5978d32e0d68fef23da48fa00bd06b0bff7ec45b00ca075c126d6bbe0cf2defc03ecc3f17bc6cc85b64271a13009c4049d7ba17de26e84e3a6e2c0348/cc24590bcead10b90763386b6f96bb027d7594c659c2d95174a6352e8b98465a50ec3e4088d0da038428abe059bbc4ae5f37b269f31a40fc048072c8a234f4e9/" toolchain/binutils.cmake

sed -i "s/GIT_TAG f3855e2caa576b1a6288129f8f99a56d2ef969dd/GIT_TAG v9.0.0/" toolchain/mingw-w64.cmake

#gcc v10
#sed -i "s/20210130/20210521/" toolchain/gcc-base.cmake
#sed -i "s/20210130/20210521/" toolchain/gcc-base.cmake
#sed -i "s/e6092eddc5feaef49bc86e800617f0475e7877ab61ae85b5c610c57e4a591939e54fdfc305c8b9438a4d2ee1fecee84c19123635f43aeaf9641806fcc4cef3ef/fb43fab69995a5aedd035198ae77d172dd168d3fe6ac62b6b767112898d63f784da32cd880d23d9991c945be93f38f4ba4399b6f2af777007bacf2b3b079bdac/" toolchain/gcc-base.cmake

#sed -i "s/20210130/20210611/" toolchain/gcc-base.cmake
#sed -i "s/20210130/20210611/" toolchain/gcc-base.cmake
#sed -i "s/e6092eddc5feaef49bc86e800617f0475e7877ab61ae85b5c610c57e4a591939e54fdfc305c8b9438a4d2ee1fecee84c19123635f43aeaf9641806fcc4cef3ef/6a047d05e04545f954099c175e4d4cdd021484a5037b515c7d44177da1afd857b3bebc51f032ff64343c760f83fccfbd7765c97e8ea915a35a323c6949d93300/" toolchain/gcc-base.cmake

#gcc v11
#sed -i "s/10-20210130/11-20210619/" toolchain/gcc-base.cmake
#sed -i "s/10-20210130/11-20210619/" toolchain/gcc-base.cmake
#sed -i "s/e6092eddc5feaef49bc86e800617f0475e7877ab61ae85b5c610c57e4a591939e54fdfc305c8b9438a4d2ee1fecee84c19123635f43aeaf9641806fcc4cef3ef/4a1266f4622385a47cfb121be1bbbbcc5d9357ce707c773dbcf312b5132fec84bdf90a1617c1f92ad5ce3af0fac7bb378f0c648c7058430c4db7c5f027d3d16d/" toolchain/gcc-base.cmake

sed -i "s/10-20210130/11-20210703/g" toolchain/gcc-base.cmake
sed -i "s/e6092eddc5feaef49bc86e800617f0475e7877ab61ae85b5c610c57e4a591939e54fdfc305c8b9438a4d2ee1fecee84c19123635f43aeaf9641806fcc4cef3ef/0681c4404bb79a8c800eb5e1e3f1c871d834f76180af8eabc5064ff54ca581fa7fbef8430f987b1204ef4d0475330ec2acbf56770cc0799e1353ba7fad42da0d/" toolchain/gcc-base.cmake
