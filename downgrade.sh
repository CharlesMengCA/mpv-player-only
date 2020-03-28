#!/bin/bash
clear
echo $0 $@

#pacman -U --needed https://archive.archlinux.org/repos/2021/07/08/extra/os/x86_64/xorg-server-1.20.11-1-x86_64.pkg.tar.zst
#pacman -U --needed https://archive.archlinux.org/repos/2021/07/08/extra/os/x86_64/xorg-server-common-1.20.11-1-x86_64.pkg.tar.zst

#pacman -U --needed https://archive.archlinux.org/repos/2019/03/12/core/os/x86_64/linux-firmware-20190212.28f5f7d-1-any.pkg.tar.xz

pacman -U --needed https://archive.archlinux.org/repos/2021/07/18/core/os/x86_64/linux-5.12.15.arch1-1-x86_64.pkg.tar.zst
#pacman -U --needed https://archive.archlinux.org/repos/2021/08/17/extra/os/x86_64/meson-0.59.0-2-any.pkg.tar.zst