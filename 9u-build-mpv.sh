#!/bin/bash
clear && echo $0 $@

BUILD64=~/mpv-winbuild-cmake/build64

cd $BUILD64

set -x #echo on

ninja update
