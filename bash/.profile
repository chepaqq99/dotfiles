# PATH
export PATH=$PATH:$HOME/.local/bin

# Default programs
export WM="dwm"
export READER="zathura"
export OPENER="xdg-open"
export PAGER="less"
export EDITOR="nvim"
export DIFFTOOL="nvim -d"
export BROWSER="librewolf"

# Clean home directory
export LESSHISTSIZE=0
export LESSHISTFILE="-"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DESKTOP_DIR="$HOME/Downloads"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export XAUTHORITY="${XDG_CONFIG_HOME:-$HOME/.config}/x11/Xauthority"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/bash/inputrc"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export MBSYNCRC="${XDG_CONFIG_HOME:-$HOME/.config}/mbsync/config"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch/config"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Program settings
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.
export MPV_OPTS="--really-quiet"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GREP_COLOR='1;92;40'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export LESS='-R'
export CM_SELECTIONS="clipboard"
export CM_DEBUG=0
export CM_OUTPUT_CLIP=0
export CM_MAX_CLIPS=20

# FZF options
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git "
export FZF_DEFAULT_OPTS="--cycle --layout=reverse --height 50% --border --color fg:#ebdbb2,hl:#d79921,fg+:#83a598,bg+:#3c3836,hl+:#fabd2f,info:#d3869b,prompt:#add8e6,spinner:#8ec07c,pointer:#83a598,marker:#98971a,header:#a89984"
export FZF_CTRL_T_COMMAND='rg --files --no-ignore --hidden --follow  2> /dev/null'
export FZF_CTRL_T_OPTS="--bind 'ctrl-r:reload(eval "$FZF_CTRL_T_COMMAND")' --header 'Press CTRL-R to reload' --select-1 --exit-0 --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_ALT_C_COMMAND="fd --type directory --hidden --follow --exclude .git"
export FZF_ALT_C_OPTS="--bind 'ctrl-r:reload(eval "$FZF_ALT_C_COMMAND")' --header 'Press CTRL-R to reload' --exact --select-1 --exit-0 --preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind 'F1:toggle-preview'"

# Start server on tty1
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && startx $XINITRC -- -keeptty vt1 &> /dev/null 
