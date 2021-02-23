#!/usr/bin/env sh

# Terminate already running bar instances
killall -q dzen2
pkill $(pgrep -f statusbar.sh)

# Wait until the processes have been shut down
while pgrep -u $UID -x dzen2 >/dev/null; do sleep 1; done

# Launch bar1 and bar2
$HOME/.config/scripts/statusbar.sh | dzen2 -e - -fn '-misc-tamzen-medium-r-normal--14-101-100-100-c-70-iso8859-1' -fg '#a6e22e' -bg '#202020' &

echo "Status Bar launched..."
