#!/bin/bash
clear
echo $0 $@

pacman -U --needed https://archive.archlinux.org/repos/2021/07/08/extra/os/x86_64/xorg-server-1.20.11-1-x86_64.pkg.tar.zst
#pacman -U --needed https://archive.archlinux.org/repos/2021/07/08/extra/os/x86_64/xorg-server-common-1.20.11-1-x86_64.pkg.tar.zst