#!/bin/bash
TMPFILE="/tmp/blacklist"
TMPFILE2="/tmp/dnsmasqlist"
BLFILE="/etc/unbound/blacklist.conf"
DNSMASQFILE="/etc/dnsmasq.d/blacklist.conf"
#CSFILE="/tmp/checksum"

#wget -O /tmp/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
wget -O $TMPFILE https://raw.githubusercontent.com/oznu/dns-zone-blacklist/master/unbound/unbound-nxdomain.blacklist
wget -O $TMPFILE2 https://raw.githubusercontent.com/oznu/dns-zone-blacklist/master/dnsmasq/dnsmasq-server.blacklist

#wget -O $CSFILE https://raw.githubusercontent.com/oznu/dns-zone-blacklist/master/dnsmasq/dnsmasq-server.blacklist.checksum
cp $TMPFILE $BLFILE
cp $TMPFILE2 $DNSMASQFILE

# if [ $(sha256sum "$BLFILE" | cut -d ' ' -f 1) = $(cat "$CSFILE") ]; then
#     cp -v $BLFILE /etc/unbound/blacklist.conf
#     systemctl restart unbound
# else
#     echo -e "\nChecksum mismatch!\n"
# fi

#cat /tmp/hosts | grep '^0\.0\.0\.0' | awk '{print "local-zone: \""$2"\" redirect\nlocal-data: \""$2" A 0.0.0.0\""}' > /etc/unbound/adservers
#cat /tmp/blacklist | grep '^0\.0\.0\.0' | awk '{print "local-zone: \""$2"\" always_nxdomain"}' > /etc/unbound/blacklist.conf

if [ -n $(pgrep -x unbound) ]; then
    systemctl restart unbound
else
    systemctl restart dnsmasq
fi
