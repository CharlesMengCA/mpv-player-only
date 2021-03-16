#!/bin/bash
clear
echo $0 $@

set -x #echo on

DIR="mpv-winbuild-cmake/"

add_option () {

	if ! grep -- "$3" packages/$1.cmake; then
		sed -i "/$2/a \        $3" packages/$1.cmake
	fi
}

cd ~

#sudo pacman -S --noconfirm --needed reflector rsync
#reflector -c CA -c US -p https -p rsync -f 12 -l 5 -n 12 --verbose --save /etc/pacman.d/mirrorlist
# sudo pacman -Sc --noconfirm

sudo pacman -S --noconfirm --needed \
       git gyp mercurial subversion ninja cmake meson ragel yasm nasm asciidoc enca \
       gperf unzip p7zip gcc-multilib python2-pip python-docutils python2-lxml python2-pillow python-mako

# warning: XXX is up to date -- skipping curl
# flex automake autoconf pkg-config patch gcc-multilib

git config --global user.email "fakeuser@outlook.com"
git config --global user.name "fakeuser"


if [ -d "$DIR" ]; then
	cd $DIR && git reset --hard HEAD && git pull

else
	git clone https://github.com/shinchiro/mpv-winbuild-cmake.git
fi


