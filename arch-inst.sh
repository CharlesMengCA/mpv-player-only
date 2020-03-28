#!/bin/bash

bootstrapper_dialog() {
 DIALOG_RESULT=$(dialog --clear --stdout --backtitle "Arch Linux Installation" --no-shadow "$@" 2>/dev/null)
}

# waiting for the latest mirror list from reflector
for (( ; ; ))
do
	mirrorCounts=$(cat /etc/pacman.d/mirrorlist | wc -l)

	if  [ $mirrorCounts -lt 50 ];	then
		break
	fi

	sleep 1
done

set -x #echo on

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

#read -p "Press any key to continue..."

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

# xfce desktop
pacman -S --noconfirm --needed lightdm lightdm-gtk-greeter xorg-server xfdesktop thunar xfwm4 xfce4-panel xfce4-session xfce4-settings xfce4-terminal mousepad

# Defaut Theme: Arc
#sed -i 's/property name="ThemeName" type="string" value="Adwaita"/property name="ThemeName" type="string" value="Arc"/' \
#	/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml

dbus-launch --exit-with-session gsettings set org.xfce.mousepad.preferences.view color-scheme 'oblivion'
dbus-launch --exit-with-session gsettings set org.xfce.mousepad.preferences.view tab-width 2
dbus-launch --exit-with-session gsettings set org.xfce.mousepad.preferences.view word-wrap true
dbus-launch --exit-with-session gsettings set org.xfce.mousepad.preferences.view show-line-numbers true

#lxde
#pacman -S --noconfirm --needed lxappearance-obconf lxde-common lxde-icon-theme lxdm lxlauncher lxpanel lxrandr lxsession lxtask lxterminal pcmanfm leafpad

#KDE Plasma
#pacman -S --noconfirm --needed lxdm plasma-desktop dolphin konsole kwrite

#lxqt
#pacman -S --noconfirm --needed lxdm ttf-dejavu oxygen-icons featherpad \
# lxqt-globalkeys lxqt-panel lxqt-qtplugin lxqt-session lxqt-themes openbox pcmanfm-qt qterminal

systemctl enable lightdm

sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/' /etc/lightdm/lightdm.conf

sed -i 's/#autologin-user=/autologin-user=root/' /etc/lightdm/lightdm.conf
groupadd -r autologin
gpasswd -a root autologin

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

mkdir -p /mnt/root/.config/xfce4/terminal
echo -e "[Configuration]\nTitleInitial=%d\n" >> /mnt/root/.config/xfce4/terminal/terminalrc

xml ed --inplace -u "//property[@name='panel-1']/property[@name='position']/@value" \
			-v "p=10;x=0;y=0" \
			/mnt/etc/xdg/xfce4/panel/default.xml

xml ed --inplace -u "//property[@name='plugin-2']/property[@name='grouping']/@value" \
			-v "0" \
			/mnt/etc/xdg/xfce4/panel/default.xml

xml ed --inplace -d "//property[@name='panel-2']" /mnt/etc/xdg/xfce4/panel/default.xml
xml ed --inplace -d "//property[@name='panels']/value[@value='2']" /mnt/etc/xdg/xfce4/panel/default.xml

umount /mnt
