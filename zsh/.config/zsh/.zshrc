# _________  _   _
#|__  / ___|| | | |
#  / /\___ \| |_| |
# / /_ ___) |  _  |
#/____|____/|_| |_|


#useful opts
setopt incappendhistory
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
unsetopt BEEP

#disable ctrl+s and ctrl+q
stty -ixon

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share/}/zsh/history"

# Basic auto/tab complete:
autoload -U compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;
_comp_options+=(globdots)	# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -a -1 --color=always $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'exa -a -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'
eval "$(zoxide init --hook pwd zsh)"

# Source needed files
[ -f "$ZDOTDIR/zsh-functions" ] && source $ZDOTDIR/zsh-functions
zsh_add_file zsh-prompt
zsh_add_file zsh-vim
zsh_add_file zsh-aliases
zsh_add_file zsh-bindings

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
# Load plugins
repos=(
	Aloxaf/fzf-tab
	wfxr/forgit
    woefe/git-prompt.zsh
	zsh-users/zsh-history-substring-search
	hlissner/zsh-autopair
	zdharma-continuum/fast-syntax-highlighting
	zsh-users/zsh-autosuggestions
)
zsh_add_plugin $repos
