#!/bin/sh
T=$(nc 127.0.0.1 7634 | awk -F '|' '{print $4}')
if [ $(pgrep -f dwm_disktemp.sh | head -n 1) -ne 0 ]; then
    while [ $T -gt 50 ]; do
        notify-send -u critical -t 5 "WARNING" "Primary disk temperature is high!"
        sleep 30s
    done & 2>&1
fi
echo $T
