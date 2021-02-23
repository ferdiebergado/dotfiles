#!/usr/bin/env bash
sudo modprobe btusb
sudo systemctl start bluealsa
bluetoothctl power on
export ALSAPCM=btheadset
