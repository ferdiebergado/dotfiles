slim_path=$(dirname $0)
fpath=($slim_path $fpath)
plugins_path="/usr/share/zsh/plugins"

autoload -U promptinit && promptinit
prompt pure

# autoload -U compinit
# compinit

autoload -U zmv

#setopt autocd
setopt extendedglob
setopt NO_NOMATCH
setopt interactivecomments
setopt noflowcontrol
setopt COMPLETE_ALIASES

export CLICOLOR=1

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

source $plugins_path/zimfw-completion/init.zsh
source $slim_path/fzf-tab/fzf-tab.plugin.zsh
source $plugins_path/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $plugins_path/zsh-history-substring-search/zsh-history-substring-search.zsh
source $plugins_path/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/doc/find-the-command/ftc.zsh
source $plugins_path/zsh-you-should-use/you-should-use.plugin.zsh
source $plugins_path/zsh-background-notify/bgnotify.plugin.zsh
source $plugins_path/zimfw-environment/init.zsh
#source $plugins_path/zimfw-input/init.zsh

source $slim_path/keys.zsh
#source $slim_path/history.zsh
#source $slim_path/completion.zsh
source $slim_path/aliases.zsh
source $slim_path/functions.zsh
source $slim_path/correction.zsh
#source $slim_path/stack.zsh

# set descriptions format to enable group support
#zstyle ':completion:*:descriptions' format '[%d]'
#zstyle ':completion:*:descriptions' format '-- %d --'

# reset broken terminal
# autoload -Uz add-zsh-hook

# function reset_broken_terminal () {
# 	printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
# }

# add-zsh-hook -Uz precmd reset_broken_terminal

# if command -v fasd >/dev/null 2>&1; then
#   eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install posix-alias)"
# fi
