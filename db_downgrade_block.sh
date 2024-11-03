#!/bin/bash
clear
echo $0 $@

block-upd(){
	if ! grep -- "IgnorePkg    = $1" /etc/pacman.conf; then
		sed -i "/#IgnorePkg   =/a IgnorePkg    = $1" /etc/pacman.conf
      grep -- "IgnorePkg    = $1" /etc/pacman.conf
	fi
}

#block-upd xorg-server-common
#block-upd xorg-server
#block-upd linux-firmware
#block-upd libmpc
#block-upd systemd 
#block-upd systemd-libs
#block-upd systemd-sysvcompat

pacman -U --needed https://archive.archlinux.org/repos/2024/03/27/core/os/x86_64/curl-8.6.0-4-x86_64.pkg.tar.zst
block-upd curl
