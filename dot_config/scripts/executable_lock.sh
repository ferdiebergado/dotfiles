#!/bin/sh

B='#00000000' # blank
C='#ffffff22' # clear ish
D='#ff00ffcc' # default
# D='#5f1c5fcc' # default
T='#ee00eeee' # text
# W='#880000bb' # wrong
W='#8d0032ff' # wrong
V='#bb00bbbb' # verifying
WI='#cecececc'
FONT1="Ticking Timebomb BB"
FONT2="Orbitron"
FONT3="Digital tech"

i3lock \
    --insidevercolor=$C \
    --ringvercolor=$V \
    \
    --insidewrongcolor=$W \
    --ringwrongcolor=$WI \
    \
    --insidecolor=$B \
    --ringcolor=$D \
    --linecolor=$B \
    --separatorcolor=$D \
    \
    --verifcolor=$T \
    --wrongcolor=$WI \
    --timecolor=$T \
    --datecolor=$T \
    --layoutcolor=$T \
    --keyhlcolor=$W \
    --bshlcolor=$W \
    \
    --screen 1 \
    --blur 1 \
    --clock \
    --indicator \
    --timestr="%H:%M:%S" \
    \
    --datestr="%a, %b %d %Y" \
    --time-font="$FONT1" \
    --timesize=36 \
    --date-font="$FONT2" \
    --datesize=14 \
    --verif-font="$FONT2" \
    --verifsize=20 \
    --wrong-font="$FONT2" \
    --wrongsize=20 \
    --wrongtext="Denied." # --datestr="%A, %B %d, %Y" \

# --keylayout 2

# --veriftext="Drinking verification can..."
# --wrongtext="Denied."
# --textsize=20
# --modsize=10
# --time-font="Ticking Timebomb BB"
# --timesize=12
# --datefont=monofur
# etc
