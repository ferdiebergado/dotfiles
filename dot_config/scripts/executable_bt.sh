#!/bin/sh

echo -e "Loading btusb kernel module...\n"
sudo modprobe btusb
echo -e "Starting bluetooth service...\n"
sudo systemctl start bluetooth
is_pulsating=$(systemctl --user -q is-active pipewire-pulse.service)
if [[ $is_pulsating -gt 0  ]]; then
    echo -e "Starting pipewire-pulse service...\n"
    systemctl --user start pipewire-pulse.service
fi
echo -e "Launching bluetoothctl..."
bluetoothctl power on
bluetoothctl
bluetoothctl power off
echo -e "Cleaning up..."
[[ $is_pulsating -gt 0 ]] && systemctl --user stop pipewire-pulse.service
sudo systemctl stop bluetooth
sudo modprobe -r btusb
echo -e "Done."
read -p "Press any key to quit."
