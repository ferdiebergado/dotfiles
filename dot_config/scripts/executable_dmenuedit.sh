#!/bin/bash
FILE=$(ls -at ~/.* | dmenu -i -p 'Edit Config:' -l 10 -fn "$DMENU_FONT" -h 32)
[[ -n $FILE ]] && urxvtc -e sh -c "vim $FILE"
