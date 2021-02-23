#!/bin/sh
#
# cmus-status-display
#
# Usage:
#   in cmus command ":set status_display_program=cmus-status-display"
#
# This scripts is executed by cmus when status changes:
#   cmus-status-display key1 val1 key2 val2 ...
#
# All keys contain only chars a-z. Values are UTF-8 strings.
#
# Keys: status file url artist album discnumber tracknumber title date
#   - status (stopped, playing, paused) is always given
#   - file or url is given only if track is 'loaded' in cmus
#   - other keys/values are given only if they are available
#

# output() {
# write status to ~/cmus-status.txt (not very useful though)
# echo "*: $*" >>~/cmus-status.txt 2>&1
# ICON=~/Music/cover.png

# dunstify -r 1996 -a cmus -i ~/Music/cover.png "cmus" "$*"

# WMI (http://wmi.modprobe.de/)
#wmiremote -t "$*" &> /dev/null
# }

# errtrap() {
#     echo "ERROR: ${BASH_SOURCE[1]} at ${BASH_LINENO[0]}" >>~/cmus-status.txt 2>&1
# }

# set -o errtrace
# trap errtrap ERR

while test $# -ge 2; do
    eval _$1='$2'
    shift
    shift
done

if test "$_status" == "playing"; then
    if test -n "$_file"; then
        # TMPDIR=/tmp/eyed3
        TMPFILE="/tmp/fileinfo.txt"
        TMPCOVER="/tmp/FRONT_COVER.jpg"
        # [[ ! -d $TMPDIR ]] && mdkir $TMPDIR

        # Save metadata and cover art to a temporary directory
        eyeD3 --write-images /tmp "$_file" >$TMPFILE

        # Extract metadata from temporary file
        extract_tag() {
            output="$(cat $TMPFILE | grep -m 1 $1 | cut -d: -f2)"
            chars=$(echo "$output" | wc -m)

            # Fallback if current song has no metadata: obtain metadata from the filename
            if test $chars -le 2; then

                FILE="$(basename "$_file" .mp3)"

                case $1 in
                    title)
                        output="$(echo "$FILE" | awk -F ' - ' '{print $1}')"
                        ;;
                    artist)
                        output="$(echo "$FILE" | awk -F ' - ' '{print $2}')"
                        ;;
                    album | date)
                        output=
                        ;;
                esac
                output="$(echo "$output" | tr -d '\\')"
            fi

            echo "$output"
        }

        # Metadata
        title="$(extract_tag title)"
        artist="$(extract_tag artist)"
        album="$(extract_tag album)"
        date="$(extract_tag date | tr -d ' ')"
        year=
        [[ -n $date ]] && year="($date)"
        duration=$(cat -A $TMPFILE | awk '/Time/{print $2}' | sed 's/\^\[\[22m//' | cut -d^ -f1)

        # Default cover art
        art="$HOME/Music/cover.png"
        [[ -f $TMPCOVER ]] && art="$TMPCOVER"

        # Check for running wms
        if [ -n "$(pgrep -x awesome)" ]; then
            # Notification for awesome wm
            display="$artist"
            [[ -n "$album" ]] && display="$display\\\n$album"
            [[ -n "$year" ]] && display="$display\\\n$year"

            echo -e "notify(\"$art\", \"$title\", \"$display\")" | awesome-client
        else
            # Notification for other wms
            display="$artist\n$album $year\n $duration"
            # dunstify -r 1996 -i "$art" "$title" "$display"
            notify-send -i "$art" "$title" "$display"
        fi

        # Clean up
        sleep 1
        [[ -f "$TMPCOVER" ]] && rm -f "$TMPCOVER"

    elif test -n "$_url"; then
        output "[$_status] $_url - $_title"
    else
        output "[$_status]"
    fi
fi
