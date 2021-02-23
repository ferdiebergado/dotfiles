#!/bin/sh
# DMENU_FONT="Ticking TimeBomb BB"
DMENU_FONT="Tempest Apache"
SB="$DMENU_NB"
SF="#00FFFF"
ACTION=$(echo -e "lock\nlogout\nreboot\nshutdown\n" | dmenu -i -h "$DMENU_HEIGHT" -p 'Exit:' -fn "$DMENU_FONT" -sb "$SB" -sf "$SF" -nb "$DMENU_NB")
# SCRIPT_DIR=~/.config/scripts
# LOGOUT=$SCRIPT_DIR/logout.sh
LOCK=~/.config/scripts/lock.sh

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

if [ -n "$ACTION" ]; then
    case "$ACTION" in
        "lock")
            # if [ $(pgrep -x dwm) -ne 0 ]; then
            #     slock
            # else
            . $LOCK
            # fi
            ;;
        "logout")
            systemctl --user stop clipmenud
            quit_session
            ;;
        "reboot")
            stop_psd
            quit_session
            reboot &
            ;;
        "shutdown")
            stop_psd
            quit_session
            poweroff &
            ;;
    esac
fi
