#!/bin/sh
HITEMP=50
HDDTEMP=$(nc 127.0.0.1 7634 | awk -F '|' '{print $4}')

test $HDDTEMP -ge $HITEMP && HDDTEMP="%{F#BF005F} $HDDTEMP"

echo "$HDDTEMP"
