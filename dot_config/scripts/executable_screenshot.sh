#!/bin/sh
FILENAME=$(date +%Y-%m-%d-%T)
FILEPATH="/tmp/$FILENAME"
IMGPATH="$HOME/Pictures/screenshots"
THUMBFILE="$FILEPATH-thumb.png"

maim "$FILEPATH.png"
convert "$FILEPATH.png" -resize 64x64 "$THUMBFILE"
mv "$FILEPATH.png" $IMGPATH &
dunstify -r 2048 -i "$THUMBFILE" "Screenshot saved to" "$IMGPATH\n$FILENAME.png"
rm -f "$THUMBFILE"
