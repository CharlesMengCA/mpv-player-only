#!/bin/bash

bootstrapper_dialog() {
 DIALOG_RESULT=$(dialog --clear --stdout --backtitle "Arch Linux Installation (VirtualBox) - $(uname -r)" --no-shadow "$@" 2>/dev/null)
}

wait_for_reflector() {
   echo -n Waiting for the latest mirror list from reflector..
   
   while pgrep reflector >/dev/null
   do
      echo -n .
      
      sleep 0.5
   done
   
   clear
}

# root password
if pacman -Qs dialog; then
  pacman -S --noconfirm --needed dialog
fi >/dev/null 2>&1

bootstrapper_dialog --title "Root password" --inputbox "Please enter a strong password for the root user.\n" 8 60
root_password="$DIALOG_RESULT"
clear

wait_for_reflector

#if [[ $(cat /etc/pacman.d/mirrorlist | wc -l) -lt 20 ]]; then
#   reflector --save /etc/pacman.d/mirrorlist --protocol https --latest 20 --sort rate >/dev/null 2>&1 &
#   wait_for_reflector
#fi

set -x #echo on

timedatectl

pacman -Sy --noconfirm --needed archlinux-keyring
pacman -Syy

# start install
echo -e "n\np\n1\n\n\nw" | fdisk /dev/sda

mkfs.ext4 /dev/sda1

mount /dev/sda1 /mnt

pacstrap -K /mnt base linux
#pacstrap -U /mnt https://archive.archlinux.org/repos/2019/03/12/core/os/x86_64/linux-firmware-20190212.28f5f7d-1-any.pkg.tar.xz

pacman -S --noconfirm --needed xmlstarlet &

genfstab /mnt >> /mnt/etc/fstab

cp arch-inst-part2.sh /mnt/root/part2.sh
chmod +x /mnt/root/part2.sh
arch-chroot /mnt /root/part2.sh $root_password
rm /mnt/root/part2.sh

xml ed -L -u "//property[@name='panel-1']/property[@name='position']/@value" \
          -v "p=8;x=0;y=0" \
          /mnt/etc/xdg/xfce4/panel/default.xml

xml ed -L -u "//property[@name='plugin-2']/property[@name='grouping']/@value" \
          -v "0" \
          /mnt/etc/xdg/xfce4/panel/default.xml

xml ed -L -d "//property[@name='panel-2']" /mnt/etc/xdg/xfce4/panel/default.xml
xml ed -L -d "//property[@name='panels']/value[@value='2']" /mnt/etc/xdg/xfce4/panel/default.xml

#xml ed -L -s "//property[@name='general']" \
#          -t elem -n "property" -v "" \
#          -i "//property[@name='general']/property[not(@name)]" -t attr -n "name" -v "SaveOnExit" \
#          -i "//property[@name='general']/property[@name='SaveOnExit']" -t attr -n "type" -v "bool" \
#          -i "//property[@name='general']/property[@name='SaveOnExit']" -t attr -n "type" -v "true" \
#          /mnt/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-session.xml

umount -R /mnt
