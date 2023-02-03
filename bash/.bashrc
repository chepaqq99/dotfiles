# _               _
#| |__   __ _ ___| |__  _ __ ___
#| '_ \ / _` / __| '_ \| '__/ __|
#| |_) | (_| \__ \ | | | | | (__
#|_.__/ \__,_|___/_| |_|_|  \___|
#

# Aliases
# color when it possible
alias ls='exa --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto' 
alias grep='grep --color=auto' 
alias fgrep='fgrep --color=auto' 
alias egrep='egrep --color=auto' 
alias diff='diff --color=auto' 
alias ip='ip -color=auto'
# Verbosity and settings that you pretty much just always are going to want.
alias ffmpeg="ffmpeg -hide_banner"
alias sudo='doas'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'
alias bc='bc -ql'
alias mkd='mkdir -pv'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la' 
alias lt='tree' 
alias df='df -h'
alias free='free -m'
# long commands
alias vpn_up='doas protonvpn connect -f'
alias vpn_down='doas protonvpn disconnect'
alias gl='git clone'
alias kl='killall'
alias tarnow='tar cfv' 
alias untar='tar xvf'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# void linux
alias xi='doas xbps-install'
alias xu='doas xbps-install xbps && doas xbps-install -Suv'
alias xr='doas xbps-remove -Rcon'
alias xs='xbps-query -Rs'
alias xl='xbps-query -l'
alias xq='xbps-query'
alias xclr='doas vkpurge rm all && doas rm -rf /var/cache/xbps/*'

# Use neovim for vim if present.
[ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d"

# doas not required for some system commands
for command in mount umount xbps-install xbps-remove xbps-reconfigure sv su shutdown poweroff reboot ; do
	alias $command="doas $command"
done; unset command

# disable ctrl+s and ctrl+q
stty -ixon
# doas complete
complete -cf doas

se() { cd; $EDITOR "$HOME/$(fzf)" ; cd -; }

mk() { mkdir -pv "$@" && cd "$@"; }

# Macros to enable yanking, killing and putting to and from the system clipboard in vi-mode. Only supports yanking and killing the whole line.
paste_from_clipboard () {
  local shift=$1

  local head=${READLINE_LINE:0:READLINE_POINT+shift}
  local tail=${READLINE_LINE:READLINE_POINT+shift}

  local paste=$(xclip -out -selection clipboard)
  local paste_len=${#paste}

  READLINE_LINE=${head}${paste}${tail}
  # Place caret before last char of paste (as in vi)
  let READLINE_POINT+=$paste_len+$shift-1
}

yank_line_to_clipboard () {
  echo $READLINE_LINE | xclip -in -selection clipboard
}

kill_line_to_clipboard () {
  yank_line_to_clipboard
  READLINE_LINE=""
}

bind -m vi-command -x '"P": paste_from_clipboard 0'
bind -m vi-command -x '"p": paste_from_clipboard 1'
bind -m vi-command -x '"yy": yank_line_to_clipboard'
bind -m vi-command -x '"dd": kill_line_to_clipboard'

# sync command history
export PROMPT_COMMAND="history -a; history -n"
export PS1="\[\e[37m\]\w\[\e[m\] \[\e[34m\]❯\[\e[m\] \[\e[37m\]"

if [ -f "$HOME/.config/bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
	GIT_PROMPT_THEME=Custom
	GIT_PROMPT_SHOW_UNTRACKED_FILES=no
    source $HOME/.config/bash-git-prompt/gitprompt.sh
fi

# fzf completion and binding
[ -f /usr/share/fzf/completion.bash ] && . /usr/share/fzf/completion.bash
[ -f /usr/share/fzf/key-bindings.bash ] && . /usr/share/fzf/key-bindings.bash
