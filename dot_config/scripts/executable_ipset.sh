#!/bin/bash
# ipset.sh
# Script to build ipset blocklist
# created by Ferdinand Saporas Bergado
# License: MIT

# Directory where the blocklists will be downloaded
DOWNLOAD_DIR="/tmp"

# The file that contains the link/s to the blocklist
SETS_FILE="/etc/ipset.sets"

# Comment character for the SETS_FILE
COMMENT="#"

# Output colors
RED="\e[31m"
GREEN="\e[32m"
BOLD_YELLOW="\e[1;33m"
NORMAL="\e[0m"

# Setup error handling
traperr() {
    echo -e "$RED ERROR: ${BASH_SOURCE[1]} at about ${BASH_LINENO[0]} $NORMAL"
    read key
}

set -o errtrace
trap traperr ERR

# The main function
main() {

    show_banner
    download_lists
    build_ipset
    echo -e "\n$GREEN Operation completed successfully! $NORMAL \n"

}

show_banner() {
    echo -e "$BOLD_YELLOW"
cat << EOF
=================================================================
| ipset.sh                                                      |
|                                                               |
| A script to download and build an ipset configuration file    |
|                                                               |
| Author: Ferdinand Saporas Bergado                             |
|                                                               |
| License: MIT                                                  |
=================================================================
EOF
    #echo -e "$NORMAL\n"
}

# Download blocklists from SETS_FILE
download_lists() {

    echo -e "\nDownloading blocklists...$NORMAL\n"

    while read set; do
        if [[ ${set::1} != $COMMENT ]]; then
            wget -nv -P $DOWNLOAD_DIR $set
        fi
    done < $SETS_FILE

    echo "done."

}

# Build the ipset.conf file
build_ipset() {

    echo -e "$BOLD_YELLOW\nAdding blacklisted ip addresses to ipset...$NORMAL\n"
    sets[0]="net"
    sets[1]="ip"
    set="set"
    systemctl stop iptables
    ipset destroy
    ipset save > /etc/ipset.conf
    systemctl restart ipset
    for i in ${sets[@]}; do
        setname="ipset-$i"
        hashname="hash:$i"
        files="$DOWNLOAD_DIR/*.$i$set"
        #echo "SETNAME: $setname; HASHNAME: $hashname; FILES: $files"
        ipset create -exist "$setname" "$hashname"
        for file in $(ls $files); do
            echo -e "FILE: $file\n"
            #j=1
            while read line; do
                #echo "LINE $j : $line"
                if [[ ${line::1} != $COMMENT ]]; then
                    ipset add -! -q "$setname" $line &
                fi
            #    #j=$((j+1))
            done < $file
            #parallel "[[ ! {} =~ ^# ]] && ipset add -! -q $setname {}" < $file
        done
    done
    ipset save > /etc/ipset.conf
    ipset list -t
    systemctl daemon-reload
    systemctl restart ipset
    systemctl start iptables

}

# Execute main
main
