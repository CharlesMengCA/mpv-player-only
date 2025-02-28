#!/bin/bash
cd ISO/vbox/

if [[ $1 == "l" || $1 == "lts" ]]; then
   ./lts.sh
else
   ./buildArchISO.sh
fi