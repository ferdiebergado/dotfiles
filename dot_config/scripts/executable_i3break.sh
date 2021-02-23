#/bin/sh 

#if [ -z $(pgrep -f i3break) ]; then
    while true; do
	    	sleep 20m
            msg_title="20 Second Break"
            msg_body="Look at something 20 feet away."
		    notify-send -u critical -t 3000 "$msg_title" "$msg_body" 
            #echo "$msg_title : $msg_body" >2>&1
    done
#fi

