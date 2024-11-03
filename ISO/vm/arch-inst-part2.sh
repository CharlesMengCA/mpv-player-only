#!/bin/bash

#echo $1
#read -p "Press any key to continue..."

sed -i 's/\\u@\\h \\W/\\W/' /etc/skel/.bashrc
echo 'PROMPT_COMMAND='\''echo -en "\033]0;'\$'(pwd | sed -e "s!$HOME!~!ig")\007"'\' >> /etc/skel/.bashrc

#cat /etc/skel/.bashrc
#read -p "Press any key to continue..."

ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime

sed -i 's/#en_US\.UTF-8/en_US.UTF-8/' /etc/locale.gen

locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

echo archlinux.cm.local > /etc/hostname

# enable dhcp
pacman -S --noconfirm --needed base-devel dhcpcd

systemctl enable dhcpcd

# grub bootloader
pacman -S --noconfirm --needed grub

grub-install /dev/sda

sed -i 's/GRUB_TIMEOUT_STYLE=menu/GRUB_TIMEOUT_STYLE=hidden/' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg

# xfce desktop
pacman -S --noconfirm --needed lightdm lightdm-gtk-greeter xorg-server xfdesktop thunar xfwm4 xfce4-panel xfce4-session xfce4-settings xfce4-terminal mousepad
#pacman -U --noconfirm --needed https://archive.archlinux.org/repos/2023/10/16/extra/os/x86_64/xfconf-4.18.1-2-x86_64.pkg.tar.zst

# Defaut Theme: Arc
#sed -i 's/property name="ThemeName" type="string" value="Adwaita"/property name="ThemeName" type="string" value="Arc"/' \
#	/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml

#lxde
#pacman -S --noconfirm --needed lxappearance-obconf lxde-common lxde-icon-theme lxdm lxlauncher lxpanel lxrandr lxsession lxtask lxterminal pcmanfm leafpad

#KDE Plasma
#pacman -S --noconfirm --needed lxdm plasma-desktop dolphin konsole kwrite

#lxqt
#pacman -S --noconfirm --needed lxdm ttf-dejavu oxygen-icons featherpad \
# lxqt-globalkeys lxqt-panel lxqt-qtplugin lxqt-session lxqt-themes openbox pcmanfm-qt qterminal

systemctl enable lightdm

useradd -mG wheel cm

#dbus-launch --exit-with-session gsettings set org.xfce.mousepad.preferences.view color-scheme 'oblivion'
#dbus-launch --exit-with-session gsettings set org.xfce.mousepad.preferences.view tab-width 2
#dbus-launch --exit-with-session gsettings set org.xfce.mousepad.preferences.view word-wrap true
#dbus-launch --exit-with-session gsettings set org.xfce.mousepad.preferences.view show-line-numbers true

sudo -Hu cm dbus-launch --exit-with-session gsettings set org.xfce.mousepad.preferences.view color-scheme 'oblivion'
sudo -Hu cm dbus-launch --exit-with-session gsettings set org.xfce.mousepad.preferences.view tab-width 2
sudo -Hu cm dbus-launch --exit-with-session gsettings set org.xfce.mousepad.preferences.view word-wrap true
sudo -Hu cm dbus-launch --exit-with-session gsettings set org.xfce.mousepad.preferences.view show-line-numbers true

sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/' /etc/lightdm/lightdm.conf

sed -i 's/#autologin-user=/autologin-user=cm/' /etc/lightdm/lightdm.conf

groupadd -r autologin
gpasswd -a cm autologin

#virtualbox configure
pacman -S --noconfirm --needed open-vm-tools xf86-video-vmware gtkmm3

systemctl enable vmtoolsd.service
systemctl enable vmware-vmblock-fuse.service

sudo -Hu cm mkdir /home/cm/mpv

sed -i 's/#user_allow_other/user_allow_other/' /etc/fuse.conf

cat <<EOF > /etc/systemd/system/shared-folder.service
[Unit]
Description=Load VMware shared folders
Requires=vmware-vmblock-fuse.service
After=vmware-vmblock-fuse.service
ConditionPathExists=.host:/LinuxFolder
ConditionVirtualization=vmware

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/vmhgfs-fuse -o allow_other -o auto_unmount .host:/LinuxFolder home/cm/mpv

[Install]
WantedBy=multi-user.target

EOF

systemctl enable shared-folder.service

sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) NOPASSWD: \/usr\/bin\/pacman/' /etc/sudoers

pacman -S --noconfirm --needed zram-generator
echo -e "[zram0]\nzram-size = min(ram, 8192)" >> /etc/systemd/zram-generator.conf

#set root password
echo "root:$1" | chpasswd
echo "cm:$1" | chpasswd

sudo -Hu cm mkdir -p /home/cm/.config/xfce4/terminal
sudo -Hu cm echo -e "[Configuration]\nTitleMode=TERMINAL_TITLE_REPLACE\n" >> /home/cm/.config/xfce4/terminal/terminalrc

#pacman -U --noconfirm --needed https://archive.archlinux.org/repos/2024/03/27/core/os/x86_64/curl-8.6.0-4-x86_64.pkg.tar.zst
#sed -i "/#IgnorePkg   =/a IgnorePkg    = curl" /etc/pacman.conf