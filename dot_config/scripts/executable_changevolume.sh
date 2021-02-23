#!/bin/bash
# changeVolume

# Arbitrary but unique message id
msgId="991049"

# getProgressString <TOTAL ITEMS> <FILLED LOOK> <NOT FILLED LOOK> <STATUS>
# For instance:
# $ getProgressString 10 "#" "-" 50
# #####-----
# Note: if you want to use | in your progress bar string you need to change the delimiter in the sed commands
getProgressString() {
    ITEMS="$1"           # The total number of items(the width of the bar)
    FILLED_ITEM="$2"     # The look of a filled item
    NOT_FILLED_ITEM="$3" # The look of a not filled item
    STATUS="$4"          # The current progress status in percent

    # calculate how many items need to be filled and not filled
    FILLED_ITEMS=$(echo "((${ITEMS} * ${STATUS})/100 + 0.5) / 1" | bc)
    NOT_FILLED_ITEMS=$(echo "$ITEMS - $FILLED_ITEMS" | bc)

    # Assemble the bar string
    msg=$(printf "%${FILLED_ITEMS}s" | sed "s| |${FILLED_ITEM}|g")
    msg=${msg}$(printf "%${NOT_FILLED_ITEMS}s" | sed "s| |${NOT_FILLED_ITEM}|g")
    echo "$msg"
}

# Change the volume using alsa(might differ if you use pulseaudio)
amixer -c 0 set Master "$@" >/dev/null

# Query amixer for the current volume and whether or not the speaker is muted
volume="$(amixer -c 0 get Master | tail -1 | awk '{print $4}' | sed 's/[^0-9]*//g')"
mute="$(amixer -c 0 get Master | tail -1 | awk '{print $6}' | sed 's/[^a-z]*//g')"
icondir="~/.icons/Papirus-Dark-Grey/48x48/status"
timeout=3000
if [[ $volume == 0 || "$mute" == "off" ]]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i "$icondir/audio-volume-muted.svg" -r "$msgId" "Volume muted" -t $timeout
else
    # Show the volume notification
    dunstify -a "changeVolume" -u low -i "$icondir/audio-volume-high.svg" -r "$msgId" \
        "Volume: ${volume}%" "$(getProgressString 10 "<b> </b>" " " $volume)" -t $timeout
fi

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"
