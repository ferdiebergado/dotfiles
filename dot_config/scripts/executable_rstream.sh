#!/bin/sh

#STATIONS=('http://stream2.flinn.com:8000/963FM.aac' 'http://radio.12round.com.au:35112/fallback' 'http://radio.enigmatic.su:8170/radio' 'http://live.kuznetsovsk.net:8000/relaxfm' 'http://s3.radionetz.de:80/1a-chillout_app.mp3' 'http://ice1.somafm.com/lush-128-aac' 'http://113fm-edge2.cdnstream.com:80/5107_128' 'http://radio.enigmatic.su:8120/radio' 'http://radio.enigmatic.su:8050/radio' 'http://radio.enigmatic.su:8090/radio' 'http://radio.enigmatic.su:8040/radio')

STATIONS=('http://stream2.flinn.com:8000/963FM.aac' 'http://radio.12round.com.au:35112/fallback' 'http://radio.enigmatic.su:8170/radio' 'http://live.kuznetsovsk.net:8000/relaxfm' 'http://cdn2.113.fm:8000/1728_128' 'http://s3.radionetz.de:80/1a-chillout_app.mp3' 'http://ice1.somafm.com/lush-128-aac' 'http://113fm-edge2.cdnstream.com:80/5107_128' 'http://streaming316.radionomy.com:80/RJM-Lounge' 'https://myradio24.org/8226' 'http://radio.enigmatic.su:8120/radio' 'http://radio.enigmatic.su:8050/radio' 'http://radio.enigmatic.su:8090/radio' 'http://radio.enigmatic.su:8040/radio' 'http://ais-edge25-fra01.cdnstream.com:80/1012_a0modernrock128k', 'https://listen.011fm.com/2660_192.mp3')

GENRES=('963 FM Memphis (Alternative)' '12 Round Radio AU Peking Duk (Electro House)' 'Enigmatic Senses' 'RelaxFM (New Age)' '113 FM Coffee House (Easy Listening/Eclectic)' 'Radionetz DE (Chillout)' 'soma fm Lush (Sensuous and mellow vocals, mostly female, with an electronic influence)' 'AceRadio (90s Alternative Rock)' 'RJM Lounge (Lounge)' 'Enigmatic Station 1' 'Enigmatic Sunshine' 'Enigmatic 3 Magnetic Chillout' 'Enigmatic Drive' 'Enigmatic Immersion', 'AceRadio Alternative', '011.FM 90s Alternative')

STATION=
GENRE=
INDEX=
RANDOM=$$$(date +%s)

select_station_index() {

    while true; do

        INDEX=$(($RANDOM % ${#STATIONS[@]}))
        STATION="${STATIONS[$INDEX]}"
        HOST=$(dig +short $(echo $STATION | cut -d: -f2 | sed 's/\///g'))

        [[ -n $HOST ]] && break

        echo "Stream unavailable. Tuning to another station..."

    done

}

play() {

    $TERMINAL -a "rstream.sh" -T "$GENRE" mpv "$STATION" &
    PID=$!

    echo $PID
}

while true; do

    select_station_index

    STATION="${STATIONS[$INDEX]}"
    GENRE="${GENRES[$INDEX]}"

    #PORT=$(echo $STATION | cut -d: -f3 | awk -F "/" '{print $1}')

    #nc -zv $HOST $PORT

    #echo "$OPEN"

    START_TIME=$(date +%s)

    # PID=$(play)

    $TERMINAL -a "rstream.sh" -T "$GENRE" mpv "$STATION" &
    PID=$!

    echo "[T: $(date +%R)] [SID: $INDEX] [PID: $PID] [STN: $STATION]"
    echo "Listening to $GENRE"

    GETPID=$(ps -p $PID --no-header)

    #echo "GETPID: $GETPID"

    while [ -n "$GETPID" ]; do

        sleep 3s

        END_TIME=$(date +%s)

        ELAPSED_TIME=$((END_TIME - START_TIME))

        ELAPSED_MINUTES=$((ELAPSED_TIME / 60))

        if [[ $ELAPSED_MINUTES -ge 30 ]]; then
            kill $PID
            break
        fi

        GETPID=$(ps -p $PID --no-header)

    done

    echo "Changing channels..."

done

