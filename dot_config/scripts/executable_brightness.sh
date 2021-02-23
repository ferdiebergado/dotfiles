#!/usr/bin/env bash
USER=d0np0br3
export XAUTHORITY="/home/$USER/.Xauthority"
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
BRIGHTNESS=4
SUMMARY="On AC Power"
STATUS="plugged"
ICON="battery-ac-adapter-icon"

on_err() {
    echo "ERROR: ${BASH_SOURCE[1]} on ${BASH_LINENO[0]}"
}

set -o errtrace
trap on_err ERR

# Dim brightness if running on battery
if [ $1 == "false" ]; then
    BRIGHTNESS=2
    SUMMARY="On battery power"
    STATUS="unplugged"
    ICON="battery-icon"
fi

BODY="AC adapter $STATUS"

# Log to syslog
echo "$BODY"

# Adjust brightness
/usr/bin/sudo -u $USER /usr/bin/echo $BRIGHTNESS >/sys/class/backlight/acpi_video0/brightness

# Send notification
if [ $(pgrep -x Xorg) -gt 0 ]; then
    NOTIFY_ICON="/home/$USER/Downloads/images/icons/$ICON.png"

    if [ -n "$(pgrep -x awesome)" ]; then
        /usr/bin/echo -e "notify(\"$NOTIFY_ICON\", \"$SUMMARY\", \"$BODY\")" | awesome-client
    else
        notifier=/usr/bin/notify-send
        dunstify=/usr/bin/dunstify
        if [ -f "$dunstify" ]; then
            notifier="$dunstify -r 19961997"
        fi

        $notifier -i "$NOTIFY_ICON" "$SUMMARY" "$BODY."
    fi
fi
