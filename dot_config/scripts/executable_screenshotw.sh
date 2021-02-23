#!/bin/sh
FILENAME=$(date +%s)
FILEPATH="/tmp/$FILENAME"
IMGPATH="$HOME/Pictures/screenshots"
THUMBFILE="$FILEPATH-thumb.png"

grim "$FILEPATH.png"
convert "$FILEPATH.png" -resize 64x64 "$THUMBFILE"
mv "$FILEPATH.png" $IMGPATH &
notify-send -i "$THUMBFILE" "Screenshot saved to" "$IMGPATH\n$FILENAME.png"
rm -f "$THUMBFILE"
