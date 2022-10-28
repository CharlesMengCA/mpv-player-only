#!/bin/bash

for (( ; ; ))
do
	echo -n .

	#ping google.com -c 1 | grep "bytes of data"; retCode=$?
	ping google.com -c 1 2>/dev/null | grep "bytes of data" >/dev/null; retCode=$?

	if [ $retCode == 0 ]; then
		break
	fi

	sleep 0.5
done 

clear

sudo pacman -Syu
