#!/bin/sh

echo -e "Loading btusb kernel module...\n"
sudo modprobe btusb
echo -e "Starting bluetooth service...\n"
sudo systemctl start bluetooth
echo -e "Launching bluetoothctl..."
bluetoothctl

echo -e "Cleaning up..."
sudo systemctl stop bluetooth
sudo modprobe -r btusb
echo -e "Done."
read -p "Press any key to quit."
