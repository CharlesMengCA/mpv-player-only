#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

block-upd () {
	if ! grep -- "$1" /etc/pacman.conf; then
		sed -i "/#IgnorePkg   =/a IgnorePkg    = $1" /etc/pacman.conf
	fi >/dev/null 2>&1
}

BUILD_DIR="mpv-winbuild-cmake/"

clear
echo $0 $@

cd

lsb_release -a &> /dev/null
if [ $? -eq 127 ]; then
  # warning: XXX is up to date -- skipping curl
  # flex automake autoconf pkg-config patch gcc-multilib subversion
  # clang is required by ffmpeg/cuda-llvmc 
  sudo pacman -S --noconfirm --needed \
		git gyp mercurial  ninja cmake ragel yasm nasm asciidoc enca \
		gperf unzip p7zip gcc-multilib python-pip clang meson po4a \
      python-mako python-j2cli python-jsonschema mold \
      lld libc++ libc++abi less
else
  sudo apt-get update
  sudo apt-get install -y \
		build-essential checkinstall bison flex gettext git mercurial ninja-build \
		gyp cmake yasm nasm automake pkg-config libtool libtool-bin gcc-multilib g++-multilib \
		clang libgmp-dev libmpfr-dev libmpc-dev libgcrypt-dev gperf ragel texinfo autopoint \
		re2c asciidoc python3-pip docbook2x unzip p7zip-full curl meson
fi

set -x #echo on

#pip3 install mako 
# --root-user-action=ignore
#rst2pdf

git config --global user.email "fakeuser@outlook.com"
git config --global user.name "fakeuser"
git config --global http.lowSpeedLimit 1000
git config --global http.lowSpeedTime 120
git config --global pull.rebase true
git config --global fetch.prune true
git config --global --add safe.directory $PWD

if [ -d "$BUILD_DIR" ]; then
	cd $BUILD_DIR && rm packages/* && git reset --hard origin/master && git pull
else
   #git clone https://github.com/CharlesMengCA/mpv-winbuild-cmake.git --depth=1
   #exit

   git clone https://github.com/shinchiro/mpv-winbuild-cmake.git --depth=1
   #git clone -b clang https://github.com/shinchiro/mpv-winbuild-cmake.git --depth=1
	
   cd $BUILD_DIR
   
   #[[ $1 == "clang" ]] && git checkout clang
   
   #git checkout -b cm a9e1712af0eb3cc1d5e926e0ea11d41ec6131ad0
   
	#git checkout 78767174caf931dbfc1efc12c492caff87d7ab19 packages/freetype2.cmake packages/ft2exec.in
fi

git am --3way $SCRIPT_DIR/Patch/rustup.patch

git log -n 3 --oneline

#export CFLAGS=-fuse-ld=mold
#df -h
