#!/bin/bash
clear
echo $0 $@

add_option () {
	if ! grep -- "$2$" /etc/pacman.conf; then
		sed -i "/$1/a $2" /etc/pacman.conf
	fi
}

blockPkg(){
	add_option "#IgnorePkg   =" "IgnorePkg    = $1"
}

#blockPkg xorg-server-common
blockPkg xorg-server
