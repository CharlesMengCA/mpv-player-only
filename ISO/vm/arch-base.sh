#!/bin/bash

set -x #echo on

bootstrapper_dialog() {
 DIALOG_RESULT=$(dialog --clear --stdout --backtitle "Arch Linux Installation" --no-shadow "$@" 2>/dev/null)
}

# find the best mirrors
pacman -Syy
#pacman -S --noconfirm --needed reflector
#reflector -c CA -c US -p https -f 12 -l 10 -n 12 --verbose --save /etc/pacman.d/mirrorlist
pacman -S --noconfirm --needed xmlstarlet dialog

# start install
echo -e "n\np\n1\n\n\nw" | fdisk /dev/sda

mkfs.ext4 /dev/sda1

mount /dev/sda1 /mnt

pacstrap /mnt base base-devel
#pacstrap -U /mnt https://archive.archlinux.org/repos/2019/03/12/core/os/x86_64/linux-firmware-20190212.28f5f7d-1-any.pkg.tar.xz
pacstrap /mnt linux

genfstab /mnt >> /mnt/etc/fstab

# root password
bootstrapper_dialog --title "Root password" --inputbox "Please enter a strong password for the root user.\n" 8 60
root_password="$DIALOG_RESULT"

cat <<EOF > /mnt/root/part2.sh
#!/bin/bash


ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime

sed -i 's/#en_US\.UTF-8/en_US.UTF-8/' /etc/locale.gen

locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

echo archlinux.cm.local > /etc/hostname

# enable dhcp
pacman -S --noconfirm --needed dhcpcd

systemctl enable dhcpcd

# grub bootloader
pacman -S --noconfirm --needed grub

grub-install /dev/sda

sed -i 's/GRUB_TIMEOUT_STYLE=menu/GRUB_TIMEOUT_STYLE=hidden/' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg
# env

#virtualbox configure
pacman -S --noconfirm --needed virtualbox-guest-utils

systemctl enable vboxservice.service

#echo -e "LinuxFolder\t\t/root/mpv\tvboxsf\t\trw\t\t0 0" >> /etc/fstab

#set root password
echo "root:${root_password}" | chpasswd
EOF

chmod +x /mnt/root/part2.sh

arch-chroot /mnt /root/part2.sh

rm /mnt/root/part2.sh

xml ed --inplace -u "//property[@name='panel-1']/property[@name='position']/@value" \
			-v "p=10;x=0;y=0" \
			/mnt/etc/xdg/xfce4/panel/default.xml

xml ed --inplace -d "//property[@name='panel-2']" /mnt/etc/xdg/xfce4/panel/default.xml
xml ed --inplace -d "//property[@name='panels']/value[@value='2']" /mnt/etc/xdg/xfce4/panel/default.xml

umount /mnt

# mount -t vboxsf -o gid=vboxsf LinuxFolder /root/mpv

