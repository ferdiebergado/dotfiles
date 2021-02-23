#!/bin/sh

echo -e "Before proceeding, make sure the ff. conditions are met:\n"
echo -e "1. Enable the ff. flags in Google Chrome/Chromium:\n"
echo -e "\t-> chrome://flags/#enable-webrtc-pipewire-capturer"
echo -e "2. The ff. environment variable is set if using a wlroots compositor (e.g. sway):\n"
echo -e "\t-> XDG_CURRENT_DESKTOP=sway"
echo -e "\n3. Xwayland should be enabled under sway config.\n"
echo -e "\n(NOTE: If screensharing does not work disable dbus-broker, reboot and try again.)"
read -p "Proceed (y/n): " proceed

if [[ $proceed == y ]]; then
    echo -e "Starting multimedia sharing services...\n"
    systemctl --user restart pipewire.service
    systemctl --user restart xdg-desktop-portal
    read -p "Press any key to clean up."

    echo -e "Stopping multimedia sharing services...\n"
    systemctl --user stop xdg-desktop-portal
    systemctl --user stop pipewire.service
    echo -e "Done.\n"
    read -p "Press any key to quit."
fi

#case $1 in
#    start)
#        #systemctl --user restart pipewire.service
#        #systemctl --user restart pipewire-pulse.service
#        #systemctl --user restart xdg-document-portal
#        #systemctl --user restart xdg-permission-store
#        #systemctl --user start xdg-desktop-portal-gtk
#        #systemctl --user restart xdg-desktop-portal-wlr
#        ;;
#    stop)
#        #systemctl --user stop xdg-desktop-portal-gtk
#        #systemctl --user stop xdg-desktop-portal-wlr
#        #systemctl --user stop xdg-document-portal
#        #systemctl --user stop xdg-permission-store
#        #systemctl --user stop pipewire.service
#        #systemctl --user stop pipewire-pulse.service
#        ;;
# esac
