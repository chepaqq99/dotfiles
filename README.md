Dotfiles
========
This repo contains dotfiles for software that I use everyday.

- beets - media organizer
- dmenu - suckless dynamic menu
- dunst - notification daemon
- dwm - suckless window manager
- mpd and ncmpcpp - music player
- mpv - video player
- neovim - text editor
- nsxiv - image viewer
- pinentry-dmenu - pinentry program
- st - suckless terminal emulator
- tmux - terminal multiplexer
- vifm - file manager
- zathura - PDF reader
- zsh and bash - unix shells

## Usage
Use GNU stow to symlink dotfiles into certain directory:
```
stow --target=TARGET */ # to symlink everything
stow --target=TARGER package # to symlink specific package
