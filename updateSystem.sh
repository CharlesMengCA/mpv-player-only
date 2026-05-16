#!/bin/bash

for (( ; ; ))
do
	echo -n .

	#ping google.com -c 1 | grep "bytes of data"; retCode=$?
	ping google.com -c 1 2>/dev/null | grep "bytes of data" >/dev/null; retCode=$?

	[ $retCode == 0 ] && break

	sleep 0.5
done 

clear
#-p rsync
if [[ $1 == "r" || $2 == "r" ]]; then
   sudo pacman -S --noconfirm --needed reflector rsync
   #reflector -c CA -c US -p https -f 12 -l 5 -n 12 --verbose --save /etc/pacman.d/mirrorlist
   sudo reflector -c CA -c US -p https --latest 12 --sort rate --verbose --save /etc/pacman.d/mirrorlist
sudo pacman -Sc --noconfirm
fi

sudo pacman -Sy --needed archlinux-keyring
sudo pacman -Syu

