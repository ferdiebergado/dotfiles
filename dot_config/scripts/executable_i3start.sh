#!/bin/sh
        #killall xautolock
        #killall break.sh
        #sh -c /home/d0np0br3/.config/scripts/break.sh &
        #compton --xrender-sync -b &
        xflux -l 14.5 -g 120.9 &
        clipit &
        unclutter --exclude-root -b
        xbacklight -set 40
        urxvtd -q -o -f
        killall devmon
        devmon --exec-on-drive "notify-send 
--icon=/home/d0np0br3/Pictures/usb_drive128.png --urgency=low 
\"Volume %l has been mounted.\"" --exec-on-unmount "notify-send --icon=/home/d0np0br3/Pictures/black_drive_usb.png --urgency=low \"Volume %l has been unmounted\"" &
        #xautolock &
        wmname LG3D
        #notify-send -i /home/d0np0br3/Downloads/images/awesome-logo.png "$(awesome -v | head -n 1 ; systemd-analyze)"
#feh         
