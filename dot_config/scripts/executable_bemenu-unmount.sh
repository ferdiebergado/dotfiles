#!/bin/sh
# Unmount a device

theme_color=\#ff6600
black=\#000000

DEVICE=$(lsblk --list -o NAME,SIZE,TYPE,MOUNTPOINT | awk '($3 == "part") && ($4 != "") && ($4 != "/") && ($4 != "/home") {print $1,$2,$4}' | bemenu -p 'Unmount:' -i -w --fn "$BEMENU_FONT" -H $BEMENU_HEIGHT --hb \#DFAF00 --hf \#000000 --tf \#dfaf00 | cut -d ' ' -f1 | tr -d '[:space:]')

[[ -n "$DEVICE" ]] && devmon --unmount /dev/$DEVICE
