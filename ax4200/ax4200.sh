#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $(dirname "$SCRIPT_DIR")/functions.sh

VARIANT="CharlesMengCA"
#VARIANT="rany2"

if [ -z ${VARIANT+x} ]; then VARIANT="openwrt"; fi

LOG_FILE="$HOME/AX4200_"$VARIANT"_Version.txt"

StartTime=$(date '+%H:%M:%S')
clear && echo_info $0 $@

# openvswitch help compile error
#sudo pacman -U --needed --noconfirm https://archive.archlinux.org/repos/2023/07/07/core/os/x86_64/groff-1.22.4-10-x86_64.pkg.tar.zst

# Essential prerequisites -- libxslt python
sudo pacman -S --needed --noconfirm git rsync time unzip wget htop quilt clang python-setuptools mold
#autoconf automake base-devel bash binutils bison bzip2 fakeroot file findutils flex gawk gcc gettext grep groff gzip libtool libelf m4 make texinfo which zlib pkgconf patch ncurses openssl sed util-linux

# Optional prerequisites, depend on the package selection
sudo pacman -S --needed --noconfirm asciidoc help2man intltool perl-extutils-makemaker swig

cd && mkdir openwrt
cd openwrt

if [[ $1 == "" ]] || [[ $1 == "kernel" ]] || [[ $1 == "config" ]]; then

   umask
   setfacl -d --set u::rwx,g::rx,o::rx .
   getfacl -d .

   # Download and update the sources
   git config --global init.defaultBranch master
   git config --global user.email "CharlesMeng@outlook.com"
   git config --global user.name "CharlesMengCA"
   git config --global http.postBuffer 52428800
   git config --global core.compression 0

   #set -x #echo on

   git init
   #git remote add origin https://git.openwrt.org/openwrt/openwrt.git
   git remote add origin https://github.com/$VARIANT/openwrt.git

   git fetch origin
   while [ $? -ne 0 ]; do git fetch origin; done

   #git checkout -b C59-canada v22.03.2
   #git checkout 9bd7d8b75657c55459c0683340617a08650f6351 -b cm
   git checkout main

   #cp -v $SCRIPT_DIR/Patches/111-hostapd-enable-FILS-by-default.patch package/network/services/hostapd/patches/

   #git revert a2662309aae1655966d7d8f31b71ddc6edbede87 --no-commit
   #git apply $SCRIPT_DIR/Patches/6_6_37.patch

   #sed -i 's/CONFIG_WERROR=y/# CONFIG_WERROR is not set/' target/linux/generic/config-6.6
   #sed -i '/CONFIG_ARM64_PAN=y/a CONFIG_ARM64_EPAN=y' target/linux/generic/config-6.6

   sed -i "s/git.openwrt.org\/feed\/packages/github.com\/openwrt\/packages/" feeds.conf.default
   sed -i "s/git.openwrt.org\/project\/luci/github.com\/CharlesMengCA\/luci/" feeds.conf.default
   #sed -i "s/git.openwrt.org\/feed\/telephony/github.com\/CharlesMengCA\/telephony/" feeds.conf.default
   
   #sed -i "s/github.com\/openwrt\/mt76/github.com\/CharlesMengCA\/mt76/" package/kernel/mt76/Makefile
   #sed -i "s/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=d8ea05914085e21bbee4dd2e2e3d6ef1005654ec/" package/kernel/mt76/Makefile
   #sed -i "s/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2023-11-10/" package/kernel/mt76/Makefile
   #sed -i "/PKG_MIRROR_HASH/d" package/kernel/mt76/Makefile

   #sed -i "s/5.15/6.1/" package/kernel/bpf-headers/Makefile

   #git reset --soft HEAD~1
   git describe > $LOG_FILE
   echo 'Script start: ' $StartTime >> $LOG_FILE
   
   [[ $2 == "test" ]] && exit

   # Update the feeds
   ./scripts/feeds update -a
   while [ $? -ne 0 ]; do ./scripts/feeds update -a; done
   ./scripts/feeds install -a

   # Configure the firmware image and the kernel
   #wget https://downloads.openwrt.org/releases/23.05.3/targets/mediatek/filogic/config.buildinfo -O .config
   #wget https://downloads.openwrt.org/snapshots/targets/mediatek/filogic/config.buildinfo -O .config
   #make menuconfig
   #make kernel_menuconfig
   #./scripts/diffconfig.sh > ~/mpv/ax4200/diffconfig.4266
fi

git clone https://github.com/flytosky-f/openwrt-vlmcsd.git package/openwrt-vlmcsd

cp $SCRIPT_DIR/diffconfig.66 .config

[[ $1 == "config" ]] && exit

#make menuconfig
make defconfig

echo 'Build start: ' $(date '+%H:%M:%S') >> $LOG_FILE

#rm -rf package/kernel/rtl8812au-ct

# Build the firmware image
make download #-j1 V=s

#linux5_ver='linux-'$(sed -n -e 's/^LINUX_KERNEL_HASH-\(.*\) =.*$/\1/p' include/kernel-5.15)'.tar.xz'
#mirror_url='https://sources.openwrt.org/'$linux5_ver
#origin_url='https://cdn.kernel.org/pub/linux/kernel/v5.x/'$linux5_ver

#if ! curl --output /dev/null --silent --head --fail "$mirror_url"; then
#  curl -f --connect-timeout 20 --retry 5 -o dl/$linux5_ver --location $origin_url
#fi

job_count=$(($(nproc)-2))

#ERROR: package/kernel/gpio-button-hotplug failed to build.
make toolchain/compile -j $job_count
make target/compile -j $job_count
make package/fail2ban/compile -j $job_count

make -j $job_count

[ $? -ne 0 ] && exit

echo 'Build end: ' $(date '+%H:%M:%S') >> $LOG_FILE
echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')

./scripts/diffconfig.sh > $SCRIPT_DIR/diffconfig.4266

build_ver=$(head -1 $(find bin/targets/ -name version.buildinfo))
build_ver="ra_"$(sed -n -e 's/^LINUX_KERNEL_HASH-\(.*\) =.*$/\1/p' include/kernel-6.6)"_"${build_ver:1}"_"$VARIANT


mkdir ~/$build_ver
cp -v $(find bin/targets/ -name openwrt-*ax4200*-sysupgrade.bin) ~/$build_ver
