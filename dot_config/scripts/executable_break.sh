#/bin/sh

function naughtyfy_send() {
        # compose the notification
    MESSAGE="local naughty = require(\"naughty\") naughty.notify({ title = \"20 Second Break\", text = \"Look at something 20 feet away.\", hover_time = 20, icon = \"/home/d0np0br3/Pictures/time-machine64.png\", icon_size = 64, bg = \"#000000\", fg = \"#ffffff\", margin = 8, width = 320})"

    #MESSAGE="local naughty = require(\"naughty\") local ICON_PATH = os.getenv(\"HOME\") .. \"/Pictures/\" naughty.notify({ string.format(\"title = %q, text = %q, hover_time = %d, icon = %q, icon_size = %d, bg = %q, fg = %q, margin = %d, width = %d\", \"20 Second Break\", \"Look at something 20 feet away.\", 20, ICON_PATH .. \"time-machine64.png\", 64, \"#000000\", \"#ffffff\", 8, 320) })"
    # send it to awesome
    echo -e $MESSAGE | awesome-client
}

#COUNTER=0

#while [ $COUNTER -eq 0 ]; do
while true; do
		sleep 20m
		#export MSGTITLE="20 Second Break"
		#export MSGTEXT="Look at something 20 feet away."
		#export MSGICON="$HOME/Pictures/Time-Machine-icon.png"
		naughtyfy_send # $MSGTITLE $MSGTEXT $MSGICON
        #sleep 10m
        #echo 'myweather.show(7)' | awesome-client
done
