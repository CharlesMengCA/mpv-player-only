#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
dirs=(${SCRIPT_DIR////$'\n'})

SHARED_DIR="/${dirs[0]}/${dirs[1]}/${dirs[2]}"

source $(find $SHARED_DIR -name functions.sh -print -quit)

clear && echo_info $0 $@

pacman -S --needed --noconfirm archiso

#set -x #echo on

cd /tmp

rm -r livecd
mkdir livecd

#chown :alpm /tmp/livecd
#chmod g+rx /tmp/livecd

cp -r /usr/share/archiso/configs/releng/* livecd
cd livecd
#sed -i -e 's#/usr/share/licenses/amd-ucode/LICENSE#/usr/share/licenses/amd-ucode/LICENSE.amd-ucode#g' build.sh

#https://github.com/archlinux/archiso/blob/master/configs/releng/packages.x86_64
cat <<EOF > packages.x86_64
dialog

#alsa-utils
#amd-ucode

arch-install-scripts

#archinstall
#b43-fwcutter

base

#bcachefs-tools
#bind
#bolt
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
#foot-terminfo
#fsarchiver
#gnu-netcat
#gpart
#gpm
#gptfdisk

grml-zsh-config

#grub
#hdparm
#hyperv
#intel-ucode
#irssi
#iw
#iwd
#jfsutils
#kitty-terminfo
#ldns
#less
#lftp
#libfido2
#libusb-compat

linux-lts

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
#memtest86+-efi

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
#openpgp-card-tools
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
#sequoia-sq
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
#tpm2-tools
#tpm2-tss
#udftools
#usb_modeswitch
#usbmuxd
#usbutils
#vim
#virtualbox-guest-utils-nox
#vpnc
#wezterm-terminfo
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

cp -af --no-preserve=ownership,mode -- $SCRIPT_DIR/arch-inst.sh airootfs/root/.automated_script.sh
cp $SCRIPT_DIR/arch-inst-part2.sh airootfs/root/

#cp -af --no-preserve=ownership,mode -- ../mpv/arch-inst.sh airootfs/root/arch-inst.sh
sed -i "/--ipv4/d" airootfs/etc/xdg/reflector/reflector.conf
sed -i "/--ipv6/d" airootfs/etc/xdg/reflector/reflector.conf

mv airootfs/etc/mkinitcpio.d/linux.preset airootfs/etc/mkinitcpio.d/linux-lts.preset
sed -i "s/vmlinuz-linux'/vmlinuz-linux-lts'/g" airootfs/etc/mkinitcpio.d/linux-lts.preset
sed -i "s/initramfs-linux.img/initramfs-linux-lts.img/g" airootfs/etc/mkinitcpio.d/linux-lts.preset
sed -i "s/vmlinuz-linux/vmlinuz-linux-lts/g" syslinux/archiso_sys-linux.cfg
sed -i "s/initramfs-linux.img/initramfs-linux-lts.img/g" syslinux/archiso_sys-linux.cfg

mkarchiso -v -o $SCRIPT_DIR ./

source=$(find $SCRIPT_DIR -name *.iso)
target=$(echo $source | sed 's/\(.*\)\//\1-lts-/')
mv -v $source $target
