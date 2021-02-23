#!/bin/bash
wget -O /etc/dnscrypt-proxy/blacklist.txt https://download.dnscrypt.info/blacklists/domains/mybase.txt
#systemctl daemon-reload
systemctl restart dnscrypt-proxy.socket
