#!/usr/bin/bash
username=d0np0br3
BRIGHTNESS=60
SUMMARY="On AC Power"
STATUS="plugged"
ICON="battery-ac-adapter-icon"

userid=$(id -u $username)
user_run_path=/run/user/$userid

export DBUS_SESSION_BUS_ADDRESS="unix:path=$user_run_path/bus"
export XDG_RUNTIME_DIR="$user_run_path"
export WAYLAND_DISPLAY="wayland-0"

on_err() {
    /usr/bin/echo "ERROR: ${BASH_SOURCE[1]} on ${BASH_LINENO[0]}"
}

set -o errtrace
trap on_err ERR

# Dim brightness if running on battery
if [ $1 == "false" ]; then
    BRIGHTNESS=20
    SUMMARY="On battery power"
    STATUS="unplugged"
    ICON="battery-icon"
fi

BODY="AC adapter $STATUS."

# Log to syslog
#/usr/bin/echo "$BODY"

# Adjust brightness
#/usr/bin/sudo -u $USER /usr/bin/echo $BRIGHTNESS >/sys/class/backlight/acpi_video0/brightness

light -S $BRIGHTNESS

# Send notification
NOTIFY_ICON="/home/$username/Downloads/images/icons/$ICON.png"
sudo -E -u $username /usr/bin/notify-send -i "$NOTIFY_ICON" "$SUMMARY" "$BODY"
