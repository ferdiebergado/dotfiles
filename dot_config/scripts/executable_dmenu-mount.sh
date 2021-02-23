#!/usr/bin/sh
# Mount devices

DEVICE=$(lsblk --list -o NAME,SIZE,TYPE,MOUNTPOINT | awk '($3 == "part") && ($4 == "") {print $1,$2,$4}' | dmenu -fn "$DMENU_FONT" -h "$DMENU_HEIGHT" -p "Mount:" -i | cut -d' ' -f1 | tr -d '[:space:]')

if [ -n "$DEVICE" ]; then
    devmon --mount /dev/$DEVICE
fi
