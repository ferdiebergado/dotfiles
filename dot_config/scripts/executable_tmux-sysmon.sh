#!/bin/sh
tmux -2u new-session \; \
    send-keys 'htop' C-m \; \
    split-window -v -p 60 \; \
    send-keys 'journalctl -f' C-m \; \
    select-pane -t 2 \; \
    split-window -h \; \
    select-pane -t 3 \; \
    send-keys 'watch -t -d -x -n 3 lsof -P -i -n' C-m \; \
    select-pane -t 2 \; \
    split-window -v -p 60 \; \
    send-keys 'tailf $WMLOG' C-m \; \
    select-pane -t 3 \; \
    split-window -v \; \
    send-keys 'tailf $XORG_LOG' C-m \; \
    select-pane -t 1 \; \
