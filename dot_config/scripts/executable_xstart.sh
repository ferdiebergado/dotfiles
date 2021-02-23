#!/bin/sh

lxsession &
wmname LG3D &
xbacklight -set 40 &
devmon --exec-on-drive "notify-send --icon=/home/d0np0br3/Pictures/usb_drive128.png --urgency=low \"Volume %l has been mounted.\"" --exec-on-unmount "notify-send --icon=/home/d0np0br3/Pictures/black_drive_usb.png --urgency=low \"Volume %l has been unmounted\"" &
urxvtd -q -o -f &
[[ -z $(systemctl --user status clipmenud | grep -ow active) ]] && systemctl --user start clipmenud &
xflux -l 14.5 -g 120.9 &
unclutter --exclude-root -b &
compton --xrender-sync --xrender-sync-fence -b
