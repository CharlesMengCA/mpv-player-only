#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/functions.sh

StartTime=$(date '+%H:%M:%S')
clear && echo $0 $@

# Essential prerequisites --noconfirm
sudo pacman -S --needed --noconfirm git libxslt python rsync time unzip wget htop quilt
#autoconf automake base-devel bash binutils bison bzip2 fakeroot file findutils flex gawk gcc gettext grep groff gzip libtool libelf m4 make texinfo which zlib pkgconf patch ncurses openssl sed util-linux 

# Optional prerequisites, depend on the package selection
sudo pacman -S --needed --noconfirm asciidoc help2man intltool perl-extutils-makemaker swig

cd
mkdir openwrt
cd openwrt

if [[ $1 == "" ]] || [[ $1 == "kernel" ]] || [[ $1 == "config" ]]; then

   umask
   setfacl -d --set u::rwx,g::rx,o::rx .
   getfacl -d .

   # Download and update the sources
   git config --global init.defaultBranch master
   git config --global user.email "CharlesMeng@outlook.com"
   git config --global user.name "CharlesMengCA"

   set -x #echo on

   git init
   git remote add origin https://git.openwrt.org/openwrt/openwrt.git
   #git remote add origin https://github.com/graysky2/openwrt.git
   git fetch origin

   #git checkout -b C59-canada v22.03.2
   git checkout master
   #git checkout 15
   git describe > ~/openwrt_version.txt
   
   # Update the feeds
   ./scripts/feeds update -a
   ./scripts/feeds install -a

   # Configure the firmware image and the kernel
   #wget https://downloads.openwrt.org/releases/22.03.3/targets/mediatek/mt7622/config.buildinfo -O .config
   #wget https://downloads.openwrt.org/snapshots/targets/mediatek/mt7622/config.buildinfo -O .config
   #make menuconfig
   #./scripts/diffconfig.sh > diffconfig
fi

cp $SCRIPT_DIR/diffconfig .config

if [[ $1 == "config" ]]; then
   exit
fi

make -j $(nproc) defconfig

# Build the firmware image
make download #-j1 V=s

#rm -rf target/linux/generic/backport-5.15/807-v6.1-0003-nvmem-core-add-error-handling-for-dev_set_name.patch
#cp -av $SCRIPT_DIR/Patches/. ./

git am --3way $SCRIPT_DIR/Patches/0001-kernel-bump-5.15-to-5.15.105.patch
git reset --soft HEAD~1

#git describe
#exit

make -j $(($(nproc)-2))

echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')

build_ver="r"$(git describe | sed 's/^.*-\(.*\)-.*$/\1/')"_"$(sed -n -e 's/^LINUX_KERNEL_HASH-\(.*\) =.*$/\1/p' include/kernel-5.15)
cd
mkdir $build_ver
cp $(find ~/openwrt/bin/targets/ -name openwrt-*-sysupgrade.itb) ~/$build_ver

# build vlmcsd
xzFile=$(find ~/openwrt/bin/targets/ -name openwrt-sdk*.xz)
tar -xf $xzFile

cd $(ls -d openwrt-sdk-*/)
git clone https://github.com/flytosky-f/openwrt-vlmcsd.git package/openwrt-vlmcsd

#make menuconfig
cp $SCRIPT_DIR/vDiffConfig .config -v
make -j $(nproc) defconfig

make package/openwrt-vlmcsd/compile V=99

cp $(find -name vlmcsd*.ipk) ~/$build_ver -v
