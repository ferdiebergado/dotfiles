#!/bin/sh

declare -a actions=('0: Connect to the Internet' '1: Read RSS Feeds' '2: Activate Bluetooth' '3: Enable Screen Sharing' '4: Kill Processes' '5: Disconnect from the Internet')
declare -a commands=('prep' 'newsboat' 'bt.sh' 'pipewire.sh' 'zsh -i -c fkill' 'disconnect')

theme_color=\#ffffb6
black=\#000000

action=$(
    for a in "${actions[@]}"; do
        echo "$a"
    done |
        bemenu -b -i -p 'ACTIONS: ' -l 10 -w --fn "$BEMENU_FONT" --hb $theme_color --hf $black --tf $theme_color --nf $theme_color --nb $black --tb $black --fb $black --ff $theme_color |
        xargs -r echo | cut -d: -f1 | tr -d [:space:]
)

if [[ -n $action ]]; then
    swaymsg exec "$TERMINAL -a 'actions' -T '${actions[$action]}' ${commands[$action]}"
fi
