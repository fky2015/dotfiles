#! /bin/sh

# Baisc
alias aliases="$VISUAL ~/.aliases.zsh"

# fix alias in command `watch`
# see, https://unix.stackexchange.com/a/25329
alias watch="/usr/bin/watch "

# GDB
alias gdb-peda="gdb -ex init-peda"
alias gdb-pwndbg="gdb -ex init-pwndbg"
alias gdb-gef="gdb -ex init-gef"

# Django
alias pm-mm="python manage.py makemigrations"
alias pm-r="python manage.py runserver"
alias pm-m="python manage.py migrate"

# Shell
alias c=clear
alias f=file
alias ct='ccat'
alias pc='proxychains4 -q'
alias dry='TERM=xterm dry'
alias dose='docker-compose'
alias kose='kompose'
alias dm='docker-machine'
alias or='optirun'
alias zshrc="$VISUAL ~/.zshrc"
alias vimrc="$VISUAL ~/.vimrc"
alias nvimrc="nvim ~/.config/nvim/"
alias ipad="ip addr | grep inet && hostname -i"
alias cdp="cd ~/playground" # change to the playground
alias cdd="cd ~/Downloads" # change to the Downloads
alias cdo="cd ~/Documents/onedrive"
alias h="htop"
alias nv="nvim"
alias v="vim"

# Onedrive
alias one="onedrive --synchronize"
alias one-d="onedrive --monitor --verbose"
# only backup, never delete remotely
alias oned='onedrive --synchronize --confdir="~/.config/onedriveEdu" --upload-only --no-remote-delete'

alias cdg="cd ~/Documents/gdrive"
alias p="pwd" # shorter
alias tmux="tmux -2" # fix the problem with vim
alias y="yay"
alias tmuxrc="vim ~/.tmux.conf"
alias destory="/bin/rm"
alias pwq='pwd | tr -d "\n" |xclip -selection c && pwd '
alias asd='code .'
alias cdt='cd /tmp'
alias yaourt="yay"
alias tb='taskbook'
alias hex='hexyl'
alias rl="rlwrap"
alias paxel="pc axel -n 10"

alias sml="rl sml"
alias cdc="cd ~/code"
alias telegram="QT_QPA_PLATFORMTHEME="" QT_STYLE_OVERRIDE="" telegram-desktop"
alias yd=ydcv
alias ub="proxychains4 -q zdict --dict urban"
alias nau='nautilus .'
alias pm='python manage.py'

# ctf usage
alias xb64d='xsel -ob 2>/dev/null | base64 -d'
alias xb64="xsel -ob 2>/dev/null | base64"

alias windows="mount.ntfs /dev/sda3 /mnt/"

alias qemu="qemu-system-x86_64"
alias mine="cd ~/code/git/mine"
alias ssr="electron-ssr"
alias ls="exa"

# LaTeX
# https://wiki.archlinux.org/title/TeX_Live
alias tlmgr="/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode"
