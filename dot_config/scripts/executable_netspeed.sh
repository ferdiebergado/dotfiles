#!/bin/bash

#shows speed on the specified device


###CHECKS####

DEVICE=$1
IS_GOOD=0
for GOOD_DEVICE in `grep ":" /proc/net/dev | awk '{print $1}' | sed s/:.*//`; do
        if [ "$DEVICE" = "$GOOD_DEVICE" ]; then
                IS_GOOD=1
                break
        fi
done
if [ $IS_GOOD -eq 0 ]; then
        echo "Device $DEVICE not found. Should be one of these:"
        grep ":" /proc/net/dev | awk '{print $1}' | sed s/:.*//
        exit 1
fi

while true; do
###REAL STUFF
LINE=`grep $1 /proc/net/dev | sed s/.*://`;
RECEIVED1=`echo $LINE | awk '{print $1}'`
TRANSMITTED1=`echo $LINE | awk '{print $9}'`
TOTAL=$(($RECEIVED1+$TRANSMITTED1))

SLP=3
sleep $SLP

LINE=`grep $1 /proc/net/dev | sed s/.*://`;
RECEIVED2=`echo $LINE | awk '{print $1}'`
TRANSMITTED2=`echo $LINE | awk '{print $9}'`
SPEED=$((($RECEIVED2+$TRANSMITTED2-$TOTAL)/$SLP))
INSPEED=$((($RECEIVED2-$RECEIVED1)/$SLP))
OUTSPEED=$((($TRANSMITTED2-$TRANSMITTED1)/$SLP))

echo "In: $(($INSPEED/1024))KB/s | Out: $(($OUTSPEED/1024))KB/s";
done
