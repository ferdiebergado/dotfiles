#!/bin/sh
tmux new -s system_monitor -d htop
#tmux select-pane -l
#tmux resize-pane -u 4
#tmux send-keys -t system_monitor "htop" c-m
tmux split-window -v -t system_monitor
tmux send-keys -t system_monitor "journalctl -f" c-m
tmux split-window -v -t system_monitor
tmux send-keys -t system_monitor "systemd-analyze" c-m
tmux split-window -h -t system_monitor
#tmux send-keys -t system_monitor "tail -n 5 /tmp/dwm.log" c-m
#tmux selectp -t system_monitor 0
tmux -2u attach -t system_monitor

