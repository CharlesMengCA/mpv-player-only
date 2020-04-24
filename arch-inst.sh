#!/bin/bash

set -x #echo on

echo -e "n\np\n1\n\n\nw" | fdisk /dev/sda

mkfs.ext4 /dev/sda1

mount /dev/sda1 /mnt

pacstrap /mnt base base-devel linux linux-firmware

genfstab /mnt >> /mnt/etc/fstab

cat <<EOF > /mnt/root/part2.sh
#!/bin/bash

timedatectl set-timezone "America/Toronto"

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

# xfce desktop
pacman -S --noconfirm --needed xfce4 lxdm mousepad

systemctl enable lxdm

#virtualbox configure
pacman -S --noconfirm --needed virtualbox-guest-utils

systemctl enable vboxservice.service

echo -e "LinuxFolder\t\t/root/mpv\tvboxsf\t\trw\t\t0 0" >> /etc/fstab

#set root password
passwd
EOF

chmod +x /mnt/root/part2.sh

arch-chroot /mnt /root/part2.sh

rm /mnt/root/part2.sh

# mount -t vboxsf -o gid=vboxsf LinuxFolder /root/mpv

