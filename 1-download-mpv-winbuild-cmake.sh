#!/bin/bash
block-upd () {
	if ! grep -- "$1" /etc/pacman.conf; then
		sed -i "/#IgnorePkg   =/a IgnorePkg    = $1" /etc/pacman.conf
	fi >/dev/null 2>&1
}

BUILD_DIR="mpv-winbuild-cmake/"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

clear
echo $0 $@

cd

lsb_release -a &> /dev/null
if [ $? -eq 127 ]
then
  # warning: XXX is up to date -- skipping curl
  # flex automake autoconf pkg-config patch gcc-multilib subversion
  # clang is required by ffmpeg/cuda-llvmc
  sudo pacman -S --noconfirm --needed \
		git gyp mercurial  ninja cmake ragel yasm nasm asciidoc enca \
		gperf unzip p7zip gcc-multilib python-pip clang meson po4a
else
  sudo apt-get update
  sudo apt-get install -y \
		build-essential checkinstall bison flex gettext git mercurial ninja-build \
		gyp cmake yasm nasm automake pkg-config libtool libtool-bin gcc-multilib g++-multilib \
		clang libgmp-dev libmpfr-dev libmpc-dev libgcrypt-dev gperf ragel texinfo autopoint \
		re2c asciidoc python3-pip docbook2x unzip p7zip-full curl meson
fi

set -x #echo on

pip3 install mako jinja2 jsonschema
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
	cd $BUILD_DIR && git reset --hard HEAD && git pull
else
   #git clone https://github.com/CharlesMengCA/mpv-winbuild-cmake.git --depth=1
   #exit 
   
	git clone https://github.com/shinchiro/mpv-winbuild-cmake.git --depth=2
   cd $BUILD_DIR
   #git checkout -b cm dabeea23e7544b3166f6ecfc95e4a50e3dafc72d
   #git am --3way $SCRIPT_DIR/Patch/amf-headers-0001-Use-git-instead-of-svn.patch
   git log
	#cd $BUILD_DIR && git checkout 78767174caf931dbfc1efc12c492caff87d7ab19 packages/freetype2.cmake packages/ft2exec.in
fi 

df -h
