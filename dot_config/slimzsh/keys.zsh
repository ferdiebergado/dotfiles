# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# do history expansion on space
bindkey ' ' magic-space
bindkey '^F' forward-word
bindkey '^B' backward-word

#bindkey '^[[Z' reverse-menu-complete
#bindkey '^?' backward-delete-char
##bindkey '^[[3~' delete-char
#bindkey "^[3;5~" delete-char
#bindkey "\e[3~" delete-char

bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

# URXVT
#bindkey '^[[7~' beginning-of-line # Home key
#bindkey '^[[8~' end-of-line       # End key

#You might also want to bind the Control-P/N keys for use in EMACS mode:
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

#You might also want to bind the `k` and `j` keys for use in VI mode:
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

#bindkey -ez
# bindkey '\ew' kill-region
# bindkey -s '\el' "ls\n"
# bindkey '^r' history-incremental-search-backward
#bindkey "^[[5~" up-line-or-history
#bindkey "^[[6~" down-line-or-history
#bindkey '^[[A' up-line-or-search
#bindkey '^[[B' down-line-or-search
#bindkey "^[[H" beginning-of-line
#bindkey "^[[1~" beginning-of-line
##bindkey "^[OH" beginning-of-line
#bindkey "^[[F" end-of-line
#bindkey "^[[4~" end-of-line
##bindkey "^[OF" end-of-line
