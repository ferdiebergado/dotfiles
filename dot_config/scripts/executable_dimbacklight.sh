#!/bin/sh

level=50

[[ "$1" == "true" ]] && level=20

/usr/bin/xbacklight -set $level
