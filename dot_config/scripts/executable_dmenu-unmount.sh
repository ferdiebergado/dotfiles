#!/bin/sh
# Unmount a device

DEVICE=$(lsblk --list -o NAME,SIZE,TYPE,MOUNTPOINT | awk '($3 == "part") && ($4 != "") && ($4 != "/") && ($4 != "/home") {print $1,$2,$4}' | dmenu -p 'Unmount:' -i -fn "$DMENU_FONT" -h "$DMENU_HEIGHT" -sb "#DFAF00" -sf "black" -nb "$DMENU_NB" | cut -d ' ' -f1 | tr -d '[:space:]')

[[ -n "$DEVICE" ]] && devmon --unmount /dev/$DEVICE
