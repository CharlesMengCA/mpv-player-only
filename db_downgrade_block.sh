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
block-upd meson

pacman -U --needed --noconfirm https://archive.archlinux.org/repos/2025/11/21/extra/os/x86_64/meson-1.9.1-2-any.pkg.tar.zst

#block-upd archiso
