#!/bin/sh
tmux -2u new-session \; \
    send-keys 'htop' C-m \; \
    split-window -v \; \
    send-keys 'journalctl -f' C-m \; \
    select-pane -t 1 \; \
