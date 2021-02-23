#!/bin/sh
# Adjusts display brightness depending on time of day
# Uses xorg-xbacklight utility

XB=/usr/bin/xbacklight

# Check for active power source
if [ $(cat /sys/class/power_supply/AC0/online) -eq 1 ]; then
    # Adjust the brightness only when the computer is running on AC power
    TIME=$(date +%k)
    BRIGHTNESS=40
    MSG="It's daytime, increasing"
    XFLUX_PID=$(pgrep -x xflux)

    # Decrease brightness if its night time
    if [[ $TIME -le 24 && $TIME -ge 18 ]]; then
        # Color temperature adjustment
        [[ -z "$XFLUX_PID" ]] && xflux -l 14.5 -g 120.9 &
        BRIGHTNESS=20
        MSG="It's night time, decreasing"
    else
        [[ $XFLUX_PID -gt 0 ]] && killall -q xflux &
    fi

    # Only set brightness if the selected brightness level is not equal to current brightness level
    CURRENT_BRIGHTNESS=$($XB -get | cut -d. -f1 | tr -d '[\n]')
    if [ $BRIGHTNESS -ne $CURRENT_BRIGHTNESS ]; then
        echo "$MSG lcd brightness..."
        $XB -set $BRIGHTNESS
    else
        echo "Brightness already set."
    fi
    # echo $BRIGHTNESS >/sys/class/backlight/acpi_video0/brightness
else
    # Automatically dim the screen when the computer is running on battery power
    echo "Running on battery, dimming the screen..."
    $XB -set 20
fi
