#!/bin/bash

if [ -n "$(ip addr show | grep $IFACE | grep -iw up)" ]; then
if [ $(cat /sys/class/net/$IFACE/carrier) -ne 0 ]; then

B="b"
K="KB"
M="MB"
G="GB"
RXB=0
for rxbytes in /sys/class/net/$IFACE/statistics/rx_bytes ; do
  let RXB+=$(<$rxbytes)
done

TXB=0
for txbytes in /sys/class/net/$IFACE/statistics/tx_bytes ; do
  let TXB+=$(<$txbytes)
done

sleep 2

RXBN=0
for rxbytes in /sys/class/net/$IFACE/statistics/rx_bytes ; do
  let RXBN+=$(<$rxbytes)
done
#divide by two for the period, multiply by 10 to allow a correct decimal place
RXDIF=$(echo $(((RXBN - RXB) *5  )))

SPEEDD=$B
if [ $RXDIF -ge 10240 ]; then
	SPEEDD=$K
	RXDIF=$(echo $((RXDIF / 1024 )) )
fi

if [ $RXDIF -ge 10240 ]; then
	SPEEDD=$M
	RXDIF=$(echo $((RXDIF / 1024 )) )
fi

if [ $RXDIF -ge 10240 ]; then
	SPEEDD=$G
	RXDIF=$(echo $((RXDIF / 1024 )) )
fi
RXDIFF=$(($RXDIF % 10 ))
RXDIFI=$(( $RXDIF / 10 ))
RXDIF="$RXDIFI"

if [ $RXDIFF -ne 0 ]; then
	RXDIF=$( echo  "$RXDIFI.$RXDIFF" )
fi

TXBN=0
for txbytes in /sys/class/net/$IFACE/statistics/tx_bytes ; do
  let TXBN+=$(<$txbytes)
done
#divide by two for the period, multiply by 10 to allow a correct decimal place
TXDIF=$(echo $(((TXBN - TXB) * 5  )))

SPEEDU=$B

if [ $TXDIF -ge 10240 ]; then
	SPEEDU=$K
	TXDIF=$(echo $((TXDIF / 1024 )) )
fi

if [ $TXDIF -ge 10240 ]; then
	SPEEDU=$M
	TXDIF=$(echo $((TXDIF / 1024 )) )
fi

if [ $TXDIF -ge 10240 ]; then
	SPEEDU=$G
	TXDIF=$(echo $((TXDIF / 1024 )) )
fi

TXDIFF=$(($TXDIF % 10 ))
TXDIFI=$(( $TXDIF / 10 ))
TXDIF="$TXDIFI"

if [ $TXDIFF -ne 0 ]; then
	TXDIF=$( echo  "$TXDIFI.$TXDIFF" )
fi

#VPNSTAT="$(ip addr show | grep -i tun)"
#RED='\033[0;31m'
#GREEN='\033[0;32m'

#if [ -n $VPNSTAT ]; then
    #VPN="U"
#else
    #VPN="D"
#fi

printf "%14s" " $RXDIF$SPEEDD/$TXDIF$SPEEDU "

fi
fi
