#!/bin/bash
clear
echo $0 $@

DIR="mpv-winbuild-cmake/"

add_option () {
	if ! grep -- "$3" packages/$1.cmake; then
		sed -i "/$2/a \        $3" packages/$1.cmake
	fi
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
       git gyp mercurial subversion ninja cmake meson ragel yasm nasm asciidoc enca \
       gperf unzip p7zip gcc-multilib python-pip clang

pip3 install rst2pdf mako

# warning: XXX is up to date -- skipping curl
# flex automake autoconf pkg-config patch gcc-multilib

git config --global user.email "fakeuser@outlook.com"
git config --global user.name "fakeuser"


if [ -d "$DIR" ]; then
	cd $DIR && git reset --hard HEAD && git pull

else
	git clone https://github.com/shinchiro/mpv-winbuild-cmake.git
fi

