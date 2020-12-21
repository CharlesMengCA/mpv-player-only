#!/bin/bash
clear
echo $0 $@
set -x #echo on

pacman -S --needed --noconfirm archiso

cd

rm -r livecd

mkdir livecd && cp -r /usr/share/archiso/configs/releng/* livecd && cd livecd
#sed -i -e 's#/usr/share/licenses/amd-ucode/LICENSE#/usr/share/licenses/amd-ucode/LICENSE.amd-ucode#g' build.sh

#exit

cat <<EOF > packages.x86_64
#
# SPDX-License-Identifier: GPL-3.0-or-later
#alsa-utils
amd-ucode
arch-install-scripts
#b43-fwcutter
base
#bind-tools
#brltty
broadcom-wl
#btrfs-progs
#clonezilla
#crda
#darkhttpd
#ddrescue
#dhclient
dhcpcd
diffutils
#dmraid
#dnsmasq
#dosfstools
#edk2-shell
efibootmgr
#espeakup
#ethtool
#exfatprogs
#f2fs-tools
#fatresize
#fsarchiver
#gnu-netcat
#gpart
#gpm
#gptfdisk
grml-zsh-config
#haveged
#hdparm
intel-ucode
#ipw2100-fw
#ipw2200-fw
#irssi
#iwd
#jfsutils
#kitty-terminfo
#lftp
linux
#linux-atm
linux-firmware
#livecd-sounds
#lsscsi
#lvm2
#lynx
#man-db
#man-pages
#mc
#mdadm
#memtest86+
mkinitcpio
mkinitcpio-archiso
mkinitcpio-nfs-utils
#mtools
nano
#nbd
#ndisc6
#nfs-utils
#nilfs-utils
#nmap
#ntfs-3g
#nvme-cli
#openconnect
openssh
#openvpn
#partclone
#parted
#partimage
#ppp
#pptpclient
reflector
#reiserfsprogs
#rp-pppoe
#rsync
#rxvt-unicode-terminfo
#sdparm
#sg3_utils
#smartmontools
#squashfs-tools
#sudo
syslinux
#systemd-resolvconf
#tcpdump
#terminus-font
#termite-terminfo
#testdisk
#tmux
#udftools
#usb_modeswitch
#usbutils
#vim
#vpnc
#wireless-regdb
#wireless_tools
#wpa_supplicant
#wvdial
#xfsprogs
#xl2tpd
zsh

EOF

: <<'END'


END

#./build.sh -v -o ~/mpv/ISO
mkarchiso -v -o ~/mpv/ISO ~/livecd/
