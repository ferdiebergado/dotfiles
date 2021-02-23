#!/bin/sh
s=$(ip addr show | grep -i tun &)
u="normal"
i="state-ok"
if [ -n "$s" ]; then
    vpn_up="up"
else
    vpn_up="down"
    u="critical"
    i="error"
fi
export vpn_status="$vpn_up"
/usr/bin/notify-send "Network Connection" "VPN is $vpn_up." -u $u -i /usr/share/icons/nitrux-icon-theme/status/24/$i.svg
exit 0
