#!/bin/bash
cd ISO/vbox/

if [[ $1 == "s" || $1 == "stable" ]]; then
   ./buildArchISO.sh
else
   ./lts.sh
fi