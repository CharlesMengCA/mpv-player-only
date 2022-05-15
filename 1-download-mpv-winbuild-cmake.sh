./#!/bin/bash
clear
echo $0 $@

BUILD_DIR="mpv-winbuild-cmake/"

block-upd () {
	if ! grep -- "$1" /etc/pacman.conf; then
		sed -i "/#IgnorePkg   =/a IgnorePkg    = $1" /etc/pacman.conf
	fi >/dev/null 2>&1
}

cd ~

lsb_release -a &> /dev/null
if [ $? -eq 127 ]
then
  PKG_MGR="pacman -S --noconfirm --needed"
else
  PKG_MGR="apt-get install -y"
fi

set -x #echo on

#sudo pacman -S --noconfirm --needed reflector rsync
#reflector -c CA -c US -p https -p rsync -f 12 -l 5 -n 12 --verbose --save /etc/pacman.d/mirrorlist
# sudo pacman -Sc --noconfirm
# clang is required by ffmpeg/cuda-llvm

sudo ${PKG_MGR} \
       git gyp mercurial subversion ninja cmake ragel yasm nasm asciidoc enca \
       gperf unzip p7zip gcc-multilib python-pip clang meson po4a 

#pacman -U --noconfirm --needed https://archive.archlinux.org/repos/2021/08/17/extra/os/x86_64/meson-0.59.0-2-any.pkg.tar.zst
#block-upd meson

pip3 install mako
#rst2pdf

# warning: XXX is up to date -- skipping curl
# flex automake autoconf pkg-config patch gcc-multilib

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
	git clone https://github.com/shinchiro/mpv-winbuild-cmake.git --depth=1
fi 

cd $BUILD_DIR

git clone --depth 1 https://github.com/mesonbuild/meson.git /usr/local/src/meson
mkdir src_packages
/usr/local/src/meson/packaging/create_zipapp.py --outfile src_packages/meson.pyz --interpreter '/usr/bin/env python3' /usr/local/src/meson
ln -sf $PWD/src_packages/meson.pyz /usr/local/bin/meson
rm -rf /usr/local/src/meson

meson --version

