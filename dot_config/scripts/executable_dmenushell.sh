#!/bin/sh

cmd="$(echo | dmenu -p 'Run:' -sb '#292931')"

if [ -n $cmd ]; then

    urxvtc -e sh -c "$cmd"

fi
