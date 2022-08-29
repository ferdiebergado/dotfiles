#FUNCTIONS

escape() {
    # Uber useful when you need to translate weird as fuck path into single-argument string.
    local escape_string_input
    echo -n "String to escape: "
    read escape_string_input
    printf '%q\n' "$escape_string_input"
}

# disk usage of the current directory
# diskusage() {
#   du -b --max-depth 1 | sort -nr | perl -pe 's{([0-9]+)}{sprintf "%.1f%s", $1>=2**30? ($1/2**30, "G"): $1>=2**20? ($1/2**20, "M"): $1>=2**10? ($1/2**10, "K"): ($1, "")}e'
# }

# speed up firefox launch
# optimizeff() { find ~ -name '*.sqlite' -exec sqlite3 '{}' 'VACUUM;' \; }

# list all date string format
alias dateh='date --help|sed -n "/^ *%%/,/^ *%Z/p"|while read l;do F=${l/% */}; date +%$F:"|'"'"'${F//%n/ }'"'"'|${l#* }";done|sed "s/\ *|\ */|/g" |column -s "|" -t'

# add blacklisted IPs to firewall
# function fwblacklists ()
# {
# 	wget -qO - http://infiltrated.net/blacklisted|awk '!/#|[a-z]/&&/./{print "iptables -A INPUT -s "$1" -j DROP"}'|sh
# }

# parse hddtemp
hdtemp() {
  nc localhost 7634 | awk -F "|" '{print $4}'
}

# print timestamps on tail -f output
tailf() { tail -f $1 | while read; do echo "[ $(date +%D-%T) ] $REPLY"; done }

# ranger() {
#     if [ -z "$RANGER_LEVEL" ]
#     then
#         /usr/bin/ranger "$@"
#     else
#         exit
#     fi
# }

# Compatible with ranger 1.4.2 through 1.7.*
#
# Automatically change the directory in bash after closing ranger
#
# This is a bash function for .bashrc to automatically change the directory to
# the last visited one after ranger quits.
# To undo the effect of this function, you can type "cd -" to return to the
# original directory.

# rg2() {
#     tempfile="$(mktemp -t tmp.XXXXXX)"
#     /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
#     test -f "$tempfile" &&
#     if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
#         cd -- "$(cat "$tempfile")"
#     fi
#     rm -f -- "$tempfile"
# }

# This binds Ctrl-O to ranger-cd:
#bindkey '"\C-o":"ranger-cd\C-m"'

# ex - archive extractor
# usage: ex <file>
ex() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

man() {
  #local width=$(tput cols)
  #[ $width -gt $MANWIDTH ] && width=$MANWIDTH
  #env MANWIDTH=$width \
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

reload () {
    exec "${SHELL}" "$@"
}

# parallel grep is a very fast implementation using gnu parallel
# pagrep() {
#   [[ -z "$1" ]] && echo 'Define a grep string and try again' && return 1
#   find . -type f -type f -not -iwholename '*.git*' | parallel -k -j150% -n 1000 -m grep -H -n "$1" {}
# }

# Enumerate terminal capabilities
term_cap_list() { infocmp -1 | sed -nu 's/^[ \000\t ]*//;s/[ \000\t ]*$//;/[^ \t\000]\{1,\}/!d;/acsc/d;s/=.*,//p'|column -c80 }

htmlescape() {
    sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g'
}

# copy using rsync with notification when done
cp() {
    rsync -avhrW --no-compress --progress $1 $2 && sync && notify-send 'Rsync' 'Data transfer finished.'
}

# Start a service when not active
start() {
    [[ -z $(systemctl status $1 | grep -ow active) ]] && systemctl start $1.service
}

dot_progress() {
    # Fancy progress function from Landley's Aboriginal Linux.
    # Useful for long rm, tar and such.
    # Usage: 
    #     rm -rfv /foo | dot_progress
    local i='0'
    local line=''

    while read line; do
        i="$((i+1))"
        if [ "${i}" = '25' ]; then
            printf '.'
            i='0'
        fi
    done
    printf '\n'
}

# Detailed info on IP Address
ipif() {
    if grep -P "(([1-9]\d{0,2})\.){3}(?2)" <<< "$1"; then
        uri="$1"
	    #curl ipinfo.io/"$1"
    else
	    ipawk=($(host "$1" | awk '/address/ { print $NF }'))
        uri=${ipawk[1]}
	    #curl ipinfo.io/${ipawk[1]}
    fi
    echo
    curl -s ipinfo.io/$uri | jq -r
}

# n() {
#         nnn "$@"

#         if [ -f $NNN_TMPFILE ]; then
#                 . $NNN_TMPFILE
#                 rm $NNN_TMPFILE
#         fi
# }

# Extract tarball online without downloading
wtar() {
    if (( $# == 0 )); then
        echo "Please provide a tar download url."
    else
        wget -qO - "$1" | tar zxvf -
    fi
}

# Create a directory and change to it afterwards
md () { mkdir -p "$@" && cd "$@"; }

# Grep a pdf file
pdfgrep() {
    if (( $# < 2 )); then
        echo "Usage: pdfgrep [pdfile] [pattern]"
    else
        pdftotext "$1" - | grep "$2"
    fi
}

# fuzzy cd - including hidden directories
fcd() {
  local dir
  dir=$(fd ${1:-.} -t d -H 2> /dev/null | fzf +m) && cd "$dir"
}

# search file contents using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# function cd() {
#     if [[ "$#" != 0 ]]; then
#         builtin cd "$@";
#         return
#     fi
#     while true; do
#         local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
#         local dir="$(printf '%s\n' "${lsd[@]}" |
#             fzf --reverse --preview '
#                 __cd_nxt="$(echo {})";
#                 __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
#                 echo $__cd_path;
#                 echo;
#                 ls -p --color=always "${__cd_path}";
#         ')"
#         [[ ${#dir} != 0 ]] || return 0
#         builtin cd "$dir" &> /dev/null
#     done
# }

## print hex value of a number
hex() {
    emulate -L zsh
    if [[ -n "$1" ]]; then
        printf "%x\n" $1
    else
        print 'Usage: hex <number-to-convert>'
        return 1
    fi
}

## Memory overview
memusage() {
    ps aux | awk '{if (NR > 1) print $5;
                   if (NR > 2) print "+"}
                   END { print "p" }' | dc
}

## Find out which libs define a symbol
lcheck() {
    if [[ -n "$1" ]] ; then
        nm -go /usr/lib/lib*.a 2>/dev/null | grep ":[[:xdigit:]]\{8\} . .*$1"
    else
        echo "Usage: lcheck <function>" >&2
    fi
}

# Change working dir in shell to last dir in lf on exit (adapted from ranger).
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# View file content without comments
# Arguments:
#   $1 - comment character
#   $2 - file
nocat() {
  #grep ^[^\\${1}] $2
  egrep -v "^$|^[[:space:]]*${1}" "$2"
}
