#!/bin/bash
T="Wireless Network"
case "$2" in
    CONNECTED)
        notify-send "$T" "Connected to $1";;
    DISCONNECTED)
        notify-send "$T" "Disconnected.";;
esac


