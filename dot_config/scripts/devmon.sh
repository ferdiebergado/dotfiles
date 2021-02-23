#!/bin/sh

# Notify on removable device mount/unmount
if [ -z "$(pgrep -x devmon)" ]; then
    notifier = "notify-send"
    [[ -n "$(pgrep -x bspwm)" ]] && notifier="dunstify -r 1999"
    devmon --exec-on-drive "notify-send --icon=/home/d0np0br3/Pictures/usb_drive128.png --urgency=low \"Volume %l has been mounted.\"" --exec-on-unmount "$notifier --icon=/home/d0np0br3/Pictures/black_drive_usb.png --urgency=low \"Volume %l has been unmounted\"" &
fi
