#!/bin/bash
clear
echo $0 $@

block-upd(){
	if ! grep -- "$1" /etc/pacman.conf; then
		sed -i "/#IgnorePkg   =/a IgnorePkg    = $1" /etc/pacman.conf
	fi
}

#block-upd xorg-server-common
#block-upd xorg-server
#block-upd linux-firmware
block-upd libmpc
