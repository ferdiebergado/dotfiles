#!/bin/sh

declare -a stations=('http://stream2.flinn.com:8000/963FM.aac' 'http://radio.12round.com.au:35112/fallback' 'http://radio.enigmatic.su:8170/radio' 'http://live.kuznetsovsk.net:8000/relaxfm' 'http://cdn2.113.fm:8000/1728_128' 'http://s3.radionetz.de:80/1a-chillout_app.mp3' 'http://ice1.somafm.com/lush-128-aac' 'http://113fm-edge2.cdnstream.com:80/5107_128' 'http://streaming316.radionomy.com:80/RJM-Lounge' 'https://myradio24.org/8226' 'http://radio.enigmatic.su:8120/radio' 'http://radio.enigmatic.su:8050/radio' 'http://radio.enigmatic.su:8090/radio' 'http://radio.enigmatic.su:8040/radio')

declare -a genres=('0 - 963 FM Memphis (Alternative)' '1 - 12 Round Radio AU Peking Duk (Electro House)' '2 - Enigmatic Senses' '3 - RelaxFM (New Age)' '4 - 113 FM Coffee House (Easy Listening/Eclectic)' '5 - Radionetz DE (Chillout)' '6 - soma fm Lush (Sensuous and mellow vocals, mostly female, with an electronic influence)' '7 - AceRadio (90s Alternative Rock)' '8 - RJM Lounge (Lounge)' '9 - Enigmatic Station 1' '10 - Enigmatic Sunshine' '11 - Enigmatic 3 Magnetic Chillout' '12 - Enigmatic Drive' '13 - Enigmatic Immersion')

choice=$(
    for g in "${genres[@]}"; do
        echo "$g"
        # done | dmenu -l 14 -i -p 'Stream:' -h "$DMENU_HEIGHT" -fn "$DMENU_FONT" -nb "$DMENU_NB" -sb '#5F1C5F' -sf '#E4E4E4' | xargs -r echo | cut -d- -f1 | tr -d ' ')
    done | bemenu -iwb -p 'Stream:' -H 24 --hb \#5f1c5f --hf \#e4e4e4 --tf \#e4e4e4 --fn 'White Rabbit 10' -l 7 | xargs -r echo | cut -d- -f1 | tr -d ' '
)

stream=${stations[$choice]}

#[[ -n $choice && $choice -le ${#genres[@]} ]] && $TERMINAL --title "mpv $stream" -e "mpv $stream" # for termite
[[ -n $choice && $choice -le ${#genres[@]} ]] && $TERMINAL -T "${genres[$choice]}" mpv "$stream"
