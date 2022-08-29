#!/bin/sh
# Unmount a device

theme_color=\#ff6600
black=\#000000

DEVICE=$(lsblk -lo NAME,SIZE,TYPE,MOUNTPOINT | awk '($3 == "part") && ($4 != "") && ($4 != "/") && ($4 != "/home") {print $1,$2,$4}' | bemenu -p 'UNMOUNT:' -i -w --fn "$BEMENU_FONT" -H $BEMENU_HEIGHT --hb \#DFAF00 --hf \#000000 --tf \#dfaf00 | cut -d ' ' -f1 | tr -d '[:space:]')

if [[ -n "$DEVICE" ]]; then
    udisksctl unmount -b /dev/$DEVICE && notify-send -i $HOME/Pictures/black_drive_usb.png "$DEVICE unmounted."
fi
