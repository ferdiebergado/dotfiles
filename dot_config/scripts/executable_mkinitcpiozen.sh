#!/usr/bin/env bash

sed -i 's/#COMPRESSION="cat"/COMPRESSION="cat"/' /etc/mkinitcpio.conf

mkinitcpio -p linux-zen

sed -i 's/COMPRESSION="cat"/#COMPRESSION="cat"/' /etc/mkinitcpio.conf
