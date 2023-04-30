#!/bin/bash
clear && echo $0 $@
set -x #echo on

pacman -S --needed --noconfirm archiso

cd ..

rm -r livecd
mkdir livecd && cp -r /usr/share/archiso/configs/releng/* livecd && cd livecd
#sed -i -e 's#/usr/share/licenses/amd-ucode/LICENSE#/usr/share/licenses/amd-ucode/LICENSE.amd-ucode#g' build.sh

#https://github.com/archlinux/archiso/blob/master/configs/releng/packages.x86_64
cat <<EOF > packages.x86_64
dialog

#alsa-utils

amd-ucode
arch-install-scripts

#archinstall
#b43-fwcutter

base

#bind
#brltty
#broadcom-wl
#btrfs-progs
#clonezilla
#cloud-init
#cryptsetup
#darkhttpd
#ddrescue
#dhclient

dhcpcd
diffutils

#dmidecode
#dmraid
#dnsmasq
#dosfstools
#e2fsprogs
#edk2-shell
#efibootmgr
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

#grub
#hdparm
#hyperv

intel-ucode

#ipw2100-fw
#ipw2200-fw
#irssi
#iw
#iwd
#jfsutils
#kitty-terminfo
#less
#lftp
#libfido2
#libusb-compat

linux

#linux-atm
#linux-firmware
#linux-firmware-marvell
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

#mkinitcpio-nfs-utils
#modemmanager
#mtools
#nano
#nbd
#ndisc6
#nfs-utils
#nilfs-utils
#nmap
#ntfs-3g
#nvme-cli
#open-iscsi
#open-vm-tools
#openconnect
#openssh
#openvpn
#partclone
#parted
#partimage
#pcsclite
#ppp
#pptpclient
#pv
#qemu-guest-agent
#refind

reflector

#reiserfsprogs
#rp-pppoe
#rsync
#rxvt-unicode-terminfo
#screen
#sdparm
#sg3_utils
#smartmontools
#sof-firmware
#squashfs-tools
#sudo

syslinux

#systemd-resolvconf
#tcpdump
#terminus-font
#testdisk
#tmux
#tpm2-tss
#udftools
#usb_modeswitch
#usbmuxd
#usbutils
#vim
#virtualbox-guest-utils-nox
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

cp -af --no-preserve=ownership,mode -- ../mpv/arch-inst.sh airootfs/root/.automated_script.sh
cp ../mpv/arch-inst-part2.sh airootfs/root/

#cp -af --no-preserve=ownership,mode -- ../mpv/arch-inst.sh airootfs/root/arch-inst.sh
sed -i "/--ipv4/d" airootfs/etc/xdg/reflector/reflector.conf
sed -i "/--ipv6/d" airootfs/etc/xdg/reflector/reflector.conf


mkarchiso -v -o ~/mpv/ISO ./
