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
   #git remote add origin https://github.com/rany2/openwrt.git
   git fetch origin

   #git checkout -b C59-canada v22.03.2
   #git checkout 0cdcf0338290a83d7679005e80cf7f547860bfc5
   git checkout master

   
   #sed -i 's/# CONFIG_KEYBOARD_MT6779 is not set/CONFIG_KEYBOARD_MT6779 is not set/' target/linux/mediatek/mt7623/config-6.1
   #sed -i 's/CONFIG_WERROR=y/# CONFIG_WERROR is not set/' target/linux/generic/config-6.1
   #sed -i '/# CONFIG_SND_SOC_MT8183 is not set/a # CONFIG_SND_SOC_MT8186 is not set' target/linux/generic/config-6.1
   
   #
   sed -i "s/git.openwrt.org\/feed\/telephony/github.com\/CharlesMengCA\/telephony/" feeds.conf.default
   sed -i "s/git.openwrt.org\/project\/luci/github.com\/CharlesMengCA\/luci/" feeds.conf.default
   
   sed -i "s/github.com\/openwrt\/mt76/github.com\/rany2\/mt76/" package/kernel/mt76/Makefile
   sed -i "s/PKG_SOURCE_VERSION:=b14c2351ddb8601c322576d84029e463d456caef/PKG_SOURCE_VERSION:=a6d684637177c6aecbc89bff6d8a5ef1f7eba6f9/" package/kernel/mt76/Makefile
   sed -i "s/PKG_SOURCE_DATE:=2023-08-14/PKG_SOURCE_DATE:=2023-08-30/" package/kernel/mt76/Makefile
   sed -i "/PKG_MIRROR_HASH/d" package/kernel/mt76/Makefile
   
   #git apply $SCRIPT_DIR/Patches/mt76.patch
   #sed -i "s/5.15/6.1/" package/kernel/bpf-headers/Makefile
   #sed -i 's/CONFIG_WERROR=y/# CONFIG_WERROR is not set/' target/linux/generic/config-6.1

   #git reset --soft HEAD~1
   git describe > ~/openwrt_version.txt
   
   [[ $1 == "test" ]] && exit
   
   # Update the feeds
   ./scripts/feeds update -a
   ./scripts/feeds install -a

   # Configure the firmware image and the kernel
   #wget https://downloads.openwrt.org/releases/23.05.0-rc3/targets/mediatek/mt7622/config.buildinfo -O .config
   #wget https://downloads.openwrt.org/snapshots/targets/mediatek/mt7622/config.buildinfo -O .config
   #make menuconfig
   #make kernel_menuconfig
   #./scripts/diffconfig.sh > diffconfig
fi

cp $SCRIPT_DIR/diffconfig .config

[[ $1 == "config" ]] && exit

make -j $(nproc) defconfig

#rm -rf package/kernel/rtl8812au-ct

# Build the firmware image
make download #-j1 V=s

curl -f --connect-timeout 20 --retry 5 -o dl/linux-5.15.130.tar.xz --location https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.15.130.tar.xz

make -j $(($(nproc)-2))

[ $? -ne 0 ] && exit

echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')

build_ver="r"$(git describe | sed 's/^.*-\(.*\)-.*$/\1/')"_"$(sed -n -e 's/^LINUX_KERNEL_HASH-\(.*\) =.*$/\1/p' include/kernel-6.1)
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

echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')