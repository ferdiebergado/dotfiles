#!/usr/bin/bash

# Define the clock
Clock() {
    DATETIME=$(date "+%a %b %d, %R")
    echo -n "$DATETIME"
}

Temp() {
    echo $(( $(cat /sys/class/thermal/thermal_zone0/temp) / 1000 ))
}

CurrentWindow() {
    xdotool getactivewindow getwindowname
}

SsdTemp() {
    nc 127.0.0.1 7634 | awk -F '|' '{print $4}'
}

Workspaces() {
    bspc wm -g | sed 's/WMLVDS1//g' | sed 's/:o/ %{F#DEDEDE}%{B#333333} /g' | sed 's/:O/ %{F#000000}%{B#FFFFFF} /g' | sed 's/:f/ %{F#DEDEDE}%{B#202020} /g' | sed 's/:F/ %{F#000000}%{B#FFFFFF} /g'
}


DiskFree() {
    df -h $1 | grep $1 | awk -F ' ' '{print $4}'
}

MemFree() {
    free -h | grep -i mem | awk -F ' ' '{print $3}'
}

CpuUsage() {
    grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}' | cut -d '.' -f1
}

Network() {
    $HOME/.config/scripts/dwm_netstat.sh
}

WifiSSID() {
    iwgetid -r
}

VpnStatus() {
    VPN="$(ip addr show | grep tun)"
    if [ -n $VPN ]; then
        echo -e "\ue1f7"
    fi
}

# Print the status bar
while true; do
    echo -e "%{l} $(Workspaces) %{F#00FFFF}  $(CurrentWindow) %{r}%{F#DEDEDE}  \ue026 $(CpuUsage)% \ue028 $(MemFree) \ue01b $(Temp)C \ue02a $(DiskFree /home)/$(DiskFree /) $(SsdTemp)C %{F#00ED64}\ue048 $(WifiSSID) $(VpnStatus)%{F#A6E22E} \ue016 $(Clock) %{F-}%{B-}"
    sleep 1
done
