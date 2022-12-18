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
  # flex automake autoconf pkg-config patch gcc-multilib
  # clang is required by ffmpeg/cuda-llvmc
  sudo pacman -S --noconfirm --needed \
		git gyp mercurial subversion ninja cmake ragel yasm nasm asciidoc enca \
		gperf unzip p7zip gcc-multilib python-pip clang meson po4a
else
  sudo apt-get update
  sudo apt-get install -y \
		build-essential checkinstall bison flex gettext git mercurial subversion ninja-build \
		gyp cmake yasm nasm automake pkg-config libtool libtool-bin gcc-multilib g++-multilib \
		clang libgmp-dev libmpfr-dev libmpc-dev libgcrypt-dev gperf ragel texinfo autopoint \
		re2c asciidoc python3-pip docbook2x unzip p7zip-full curl meson
fi

set -x #echo on

#sudo pacman -S --noconfirm --needed reflector rsync
#reflector -c CA -c US -p https -p rsync -f 12 -l 5 -n 12 --verbose --save /etc/pacman.d/mirrorlist
# sudo pacman -Sc --noconfirm

#pacman -U --noconfirm --needed https://archive.archlinux.org/repos/2021/08/17/extra/os/x86_64/meson-0.59.0-2-any.pkg.tar.zst
#block-upd meson

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
	git clone https://github.com/shinchiro/mpv-winbuild-cmake.git --depth=2
   cd $BUILD_DIR
   #git checkout -b cm dabeea23e7544b3166f6ecfc95e4a50e3dafc72d
   git am --3way $SCRIPT_DIR/Patch/amf-headers-0001-Use-git-instead-of-svn.patch
   git status
#   git clone https://github.com/CharlesMengCA/mpv-winbuild-cmake.git --depth=1
	#cd $BUILD_DIR && git checkout 78767174caf931dbfc1efc12c492caff87d7ab19 packages/freetype2.cmake packages/ft2exec.in
fi 

#cd $BUILD_DIR
#my_meson=$(find ~/mpv -name meson.pyz)
#mkdir meson_build
#cp ${my_meson} meson_build
#ln -sf $PWD/meson_build/meson.pyz /usr/local/bin/meson
#meson --version

df -h