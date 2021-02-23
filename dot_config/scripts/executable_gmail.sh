#!/usr/bin/env bash
set -x

asc="$HOME/gmailp.txt.asc"
decrypted="$(gpg -d $asc)"
user=$(echo "$decrypted" | awk 'NR==1')
pass=$(echo "$decrypted" | awk 'NR==2')

curl -u $user:$pass --silent "https://mail.google.com/mail/feed/atom" | tr -d '\n' | awk -F '<entry>' '{for (i=2; i<=NF; i++) {print $i}}' | sed -n "s/<title>\(.*\)<\/title.*name>\(.*\)<\/name>.*/\2 - \1/p"
