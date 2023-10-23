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
sudo pacman -Syu

#sudo pacman -S --noconfirm --needed reflector rsync
#reflector -c CA -c US -p https -p rsync -f 12 -l 5 -n 12 --verbose --save /etc/pacman.d/mirrorlist
# sudo pacman -Sc --noconfirm
