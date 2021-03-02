#!/bin/sh
# DMENU_FONT="Ticking TimeBomb BB"
FONT="Tempest Apache"
#SB="$DMENU_NB"
#SF="#00FFFF"
ACTION=$(echo -e "lock\nlogout\nreboot\nshutdown\n" | bemenu -i -H $BEMENU_HEIGHT -p ' EXIT:' --fn "$FONT" --hf \#00ffff --tf \#00ffff -w)

# SCRIPT_DIR=~/.config/scripts
# LOGOUT=$SCRIPT_DIR/logout.sh
# LOCK=~/.config/scripts/lock.sh

stop_psd() {
    notify-send "System halt initiated." "Logging off..." -t 3000 &
    if [ -n "$(systemctl --user status psd | grep -ow active)" ]; then
        systemctl --user stop psd
        # sleep 3s
    fi
}

quit_session() {
    tmux kill-server &
    killall -q redshift &
    killall -q devmon &
    systemctl --user stop clipmenud
    systemctl --user stop dunst
    systemctl --user stop dbus-broker &

    [[ -n "$(pgrep dwm)" ]] && killall -q dwm
    [[ -n "$(pgrep awesome)" ]] && (echo -e "awesome.quit()" | awesome-client)
    [[ -n "$(pgrep bspwm)" ]] && bspc quit
}

notify() {
    notify-send "System halt initiated." "Logging off..." &
}

if [ -n "$ACTION" ]; then
    case "$ACTION" in
        "lock")
            # if [ $(pgrep -x dwm) -ne 0 ]; then
            #     slock
            # else
            #. $LOCK
            #swaylock-fancy -f Michroma
            swaylock \
                --screenshots \
                --clock \
                --indicator \
                --indicator-radius 100 \
                --indicator-thickness 6 \
                --effect-blur 7x5 \
                --effect-vignette 0.5:0.5 \
                --ring-color 2c7a92 \
                --key-hl-color 880033 \
                --line-color 00000000 \
                --inside-color 00000088 \
                --separator-color 00000000 \
                --grace 2 \
                --fade-in 0.2 \
                --font "Ticking Timebomb BB" \
                --font-size 32 \
                -f
            # fi
            ;;
        "logout")
            #systemctl --user stop clipmenud
            #quit_session
            swaymsg exit
            ;;
        "reboot")
            #stop_psd
            #quit_session
            #notify
            reboot
            ;;
        "shutdown")
            #stop_psd
            #quit_session
            #notify
            poweroff
            ;;
    esac
fi
