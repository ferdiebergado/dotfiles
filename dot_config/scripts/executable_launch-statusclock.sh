#!/usr/bin/env sh

# Terminate already running bar instances
killall -q lemonbar
killall -q statusclock.sh

# Wait until the processes have been shut down
while pgrep -u $UID -x lemonbar >/dev/null; do sleep 1; done

# Launch bar
$HOME/.config/scripts/statusclock.sh | lemonbar -f "Misc Termsyn"-10 -f '-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1' -F#eeeeee -B#202020

echo "Status Bar launched..."
