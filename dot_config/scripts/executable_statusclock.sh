#!/usr/bin/bash

# Colors
FG="%{F#a4e22e}"
WARNING="%{F#ff0000}"
OCCUPIED="%{F#cccccc}"
EMPTY="%{F#666666}"

TEMP_UNIT="C"

# Define the clock
Clock() {
    DATETIME=$(date "+%a %b %d, %R")
    echo -ne "%{F#00ffff}\ue016 $DATETIME"
}

ActiveWindow() {
    xdotool getactivewindow getwindowname
}

Temp() {
    TEMP=$(( $(cat /sys/class/thermal/thermal_zone0/temp) / 1000 ))
    TEMP_ICON="\ue01b"
    TEMP_STATUS="$TEMP_ICON $TEMP$TEMP_UNIT"
    if [ $TEMP -ge 60 ]; then
        TEMP_STATUS="$WARNING $TEMP_STATUS $FG"
    fi
    echo -e "$TEMP_STATUS"
}

Disktemp() {
    DISKTEMP=$(nc 127.0.0.1 7634 | cut -d '|' -f4)
    DISKTEMP_ICON="\ue01d"
    DISKTEMP_STATUS="$DISKTEMP_ICON $DISKTEMP$TEMP_UNIT"

    if [ $DISKTEMP -ge 60 ]; then
        DISKTEMP_STATUS="$WARNING $DISKTEMP_STATUS $FG"
    fi
    echo -e "$DISKTEMP_STATUS"
}

Workspaces() {
    TT="\ue002"
    TF="\ue006"
    LM="\ue000"
    echo -e $(bspc wm -g | sed 's/WMLVDS1//g' | sed "s/:o/$OCCUPIED /g" | sed "s/:O/$FG /g" | sed "s/:f/$EMPTY /g" | sed "s/:F/$FG /g" | sed 's/:LT//g' | sed "s/:TT/ \\$TT /g" | sed "s/:TF/ \\$TF /g" | sed "s/:LM/ \\$LM /g" | sed 's/:G//g')
}

Battery() {
    BAT_ICON_FULL="\ue042"
    BAT_ICON_DISCHARGING="\ue03e"
    BAT_ICON_CHARGING="\ue040"
    BAT="$(acpi -b)"
    BAT_STATE=$(echo $BAT | awk '{print $3}' | sed 's/,//g')
    BAT_PERCENTAGE="$(echo $BAT | cut -d ',' -f2)"
    case "$BAT_STATE" in
        "Full"|"Unknown")
            BAT_STATUS="$BAT_ICON_FULL"
            ;;
        "Discharging")
            BAT_STATUS="$BAT_ICON_DISCHARGING$BAT_PERCENTAGE"
            #BAT_RAW=$(echo $BAT_PERCENTAGE | sed 's/%//g')
            #if [ $BAT_RAW  -ge ]
            ;;
        "Charging")
            BAT_STATUS="$BAT_ICON_CHARGING$BAT_PERCENTAGE"
            ;;
    esac
    echo -e "$BAT_STATUS"
}

# Print the status bar
while true; do
    echo "%{l} $(Workspaces) $FG $(ActiveWindow)%{r} $(Temp) $(Disktemp) $(Battery) $(Clock) %{F-}%{B-}"
    sleep 1
done
