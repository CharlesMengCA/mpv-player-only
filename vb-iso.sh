#!/bin/bash
[ "$EUID" -ne 0 ] && exec su -c "$0 $*"

cd ISO/vbox/

if [[ $1 == "l" || $1 == "lts" ]]; then
   ./lts.sh
else
   ./buildArchISO.sh
fi