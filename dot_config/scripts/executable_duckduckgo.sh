#!/bin/sh

ddg='#de5833'

search=$(echo | dmenu -p " Duckduckgo Search:" -h "$DMENU_HEIGHT" -fn "$DMENU_FONT" -nb "$DMENU_NB" -nf "$ddg" -sb "$DMENU_NB" -sf "$ddg")

[[ -n "$(pgrep -x chrome)" ]] && BROWSER=google-chrome-stable

[[ -n $search ]] && ${BROWSER} "https://duckduckgo.com/?q=$search" 2>>$WMLOG &
