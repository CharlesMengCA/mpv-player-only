#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/functions.sh

StartTime=$(date '+%H:%M:%S')
clear && echo $0 $@

# Essential prerequisites --noconfirm
sudo pacman -U --needed --noconfirm https://archive.archlinux.org/repos/2023/07/07/core/os/x86_64/groff-1.22.4-10-x86_64.pkg.tar.zst

sudo pacman -S --needed --noconfirm git libxslt python rsync time unzip wget htop quilt clang mold
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
   git fetch origin

   #git checkout -b C59-canada v22.03.2
   #git checkout 0cdcf0338290a83d7679005e80cf7f547860bfc5
   git checkout master
   
   #sed -i 's/CONFIG_WERROR=y/# CONFIG_WERROR is not set/' target/linux/generic/config-5.15
   git apply $SCRIPT_DIR/Patches/mt76.patch
   
   #git reset --soft HEAD~1
   git describe > ~/openwrt_version.txt

   # Update the feeds
   ./scripts/feeds update -a
   ./scripts/feeds install -a

   # Configure the firmware image and the kernel
   #wget https://downloads.openwrt.org/releases/22.03.5/targets/mediatek/mt7622/config.buildinfo -O .config
   #wget https://downloads.openwrt.org/snapshots/targets/mediatek/mt7622/config.buildinfo -O .config
   #make menuconfig
   #make kernel_menuconfig
   #./scripts/diffconfig.sh > diffconfig
fi

cp $SCRIPT_DIR/diffconfig.5 .config

[[ $1 == "config" ]] && exit

make -j $(nproc) defconfig

# Build the firmware image
make download #-j1 V=s

make -j $(($(nproc)-2))

[ $? -ne 0 ] && exit

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
