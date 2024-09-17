#!/bin/bash
cd ISO/vm/

if [[ $1 == "s" || $1 == "stable" ]]; then
   ./buildArchISO.sh
else
   ./lts.sh
fi
