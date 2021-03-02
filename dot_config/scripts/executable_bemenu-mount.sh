#!/usr/bin/sh
# Mount devices

DEVICE=$(lsblk --list -o NAME,SIZE,TYPE,MOUNTPOINT | awk '($3 == "part") && ($4 == "") {print $1,$2,$4}' | bemenu --fn 'Orbitron 10' -H $BEMENU_HEIGHT -p "Mount:" -i -w --hf \#2c7a92 --tf \#2c7a92 | cut -d' ' -f1 | tr -d '[:space:]')

if [ -n "$DEVICE" ]; then
    #devmon --mount /dev/$DEVICE
    udisksctl mount -b /dev/$DEVICE && notify-send -i $HOME/Pictures/usb_drive128a.png "$DEVICE mounted."
fi
