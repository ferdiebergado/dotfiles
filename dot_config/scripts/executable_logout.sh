#!/bin/sh
tmux kill-server

[[ -n "$(pgrep dwm)" ]] && killall -q dwm
[[ -n "$(pgrep awesome)" ]] && (echo -e "awesome.quit()" | awesome-client)
[[ -n "$pgrep bspwm" ]] && bspc quit
