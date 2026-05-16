#!/bin/bash
[ "$EUID" -ne 0 ] && exec su -c "$0 $*"

cd ISO/vm/

if [[ $1 == "s" || $1 == "stable" ]]; then
   ./buildArchISO.sh
else
   ./lts.sh
fi