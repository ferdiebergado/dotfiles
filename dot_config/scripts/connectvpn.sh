#!/bin/env bash

# start vpn
connectvpn() {
    sleep 3
    echo -e "\nConnecting to VPN...\n"
    U="d0np0br3"
    # VPN_LIST="/tmp/vpngate.csv"
    # VPN_CONFIG="/tmp/vpngate.conf"
    # /usr/bin/wget -O $VPN_LIST http://www.vpngate.net/api/iphone && cat $VPN_LIST | sort -k5 -t, -n | grep -w TH | tail -n 1 | awk -F ',' '{$15}' | base64 -di > $VPN_CONFIG
    echo -e "\nFetching vpn configuration...\n"
    sudo -u $U /home/$U/.config/scripts/vpnconfig
    # sleep 3
    echo -e "\nStarting VPN connection...\n"
    chown -v $U:root /tmp/vpngate.*
    cp -v /tmp/vpngate.conf /etc/openvpn/client/vpngate.conf && systemctl start openvpn-client@vpngate
}

connectvpn
