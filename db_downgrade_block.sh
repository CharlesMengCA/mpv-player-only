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

pacman -U --needed --noconfirm https://archive.archlinux.org/repos/2024/09/27/extra/os/x86_64/archiso-79-1-any.pkg.tar.zst

block-upd archiso
