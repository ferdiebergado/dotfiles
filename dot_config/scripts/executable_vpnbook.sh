#!/bin/sh
PW=$(proxychains curl -s https://www.vpnbook.com | grep -w "Password:" -m 1 | cut -d: -f2 | awk -F'<' '{print $1}' | sed -e 's/[[:space:]]//g')
[[ -n $PW ]] && echo -e "vpnbook\n$PW" > ~/vpnbook.txt && megaput ~/vpnbook.txt -u ferdiebergado@yahoo.com -p stephferdie0218 -proxy socks5://localhost:9050
