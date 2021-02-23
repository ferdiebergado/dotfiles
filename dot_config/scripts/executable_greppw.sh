#!/bin/bash
echo -e "\nDownloading password data from vpnbook.com...\n"
pw=$(curl https://www.vpnbook.com/freevpn | grep -i password | tail -n 1 | cut -d '>' -f 3)
newpw=${pw:0:7}
target=~/auth.txt
#dest=~/"GoogleDrive"
echo -e "\nNew password is $newpw"
(echo vpnbook && echo $newpw) > $target
echo -e "New password saved to $target\n"
#sudo cp -v $target $dest
#sudo rclone sync $dest remote:
#echo "Backed up to Google Drive."
