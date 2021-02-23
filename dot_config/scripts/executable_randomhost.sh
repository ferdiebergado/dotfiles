#!/bin/bash

### BEGIN INIT INFO
# Provides:          randomhostname
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Changing hostname to random value
# Description:       Changing hostname to random value
### END INIT INFO

#service network-manager stop

old=$(cat /etc/hostname)
#new=$(tr -dc 'A-Z0-9' < /dev/urandom | head -c8)
#new=$(xxd -l8 -ps /dev/urandom)
#new="$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c8)"
new=$(date | sha1sum | head -c16)
#sed -i "s/$old/$new/g" /etc/hosts
sed -i "s/$old/$new/g" /etc/hostname
hostname "$new"

#service network-manager start

exit 0
