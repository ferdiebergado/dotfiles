#!/bin/sh

declare -a apps=('htop' 'journalctl -f' 'tailf $WMLOG')
bspc desktop -f 8
for c in "${apps[@]}"; do
    $TERMINAL -e sh -c "$c" &
    bspc node -p south
done
