#!/bin/bash
TORCMD="tor --defaults-torrc /usr/share/tor/tor-service-defaults-torrc -f /etc/tor/torrc --RunAsDaemon 1"
sudo -b daemon -f -d -- firejail --profile=/etc/firejail/tor.profile $TORCMD

