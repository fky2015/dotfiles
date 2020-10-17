#! /bin/sh

# Baisc
alias aliases="$VISUAL ~/.aliases.zsh"

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
alias dm='docker-machine'
alias or='optirun'
alias zshrc="$VISUAL ~/.zshrc"
alias vimrc="$VISUAL ~/.vimrc"
alias nvimrc="nvim ~/.config/nvim/init.vim"
alias ipad="ip addr | grep inet && hostname -i"
alias cdp="cd ~/playground" # change to the playground
alias cdd="cd ~/Downloads" # change to the Downloads
alias cdo="cd ~/Documents/onedrive"

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
alias installrc="vim /home/fky/code/git/mine/dotfile/reinstall-OS"
alias pwq='pwd | tr -d "\n" |xclip -selection c && pwd '
alias asd='code .'
alias cdt='cd /tmp'
alias yaourt="yay"
alias tb='taskbook'
alias hex='hexyl'
alias rl="rlwrap"
alias paxel="pc axel -n 10"

# vps
alias vps2="ssh -p '27955' 'root@138.128.217.229'"
alias vps-ali="ssh fky@59.110.233.235"
alias vps-hw="ssh fky@119.3.227.198"
alias vps-hw-root="ssh root@119.3.227.198"
alias vps3="ssh fky@172.96.201.10 -p 31234"
alias vps4="ssh root@118.25.113.189"
alias vps-np1="ssh root@10.1.139.231"
alias vps-np2="ssh root@10.1.139.232"
alias vps-np3="ssh root@10.1.139.233"

alias sml="rl sml"
alias cdc="cd ~/code"
alias telegram="QT_QPA_PLATFORMTHEME="" QT_STYLE_OVERRIDE="" telegram-desktop"
alias yd=ydcv
alias ub="proxychains4 -q zdict --dict urban"
alias nau='nautilus .'
alias pm='python manage.py'
alias n='nnn'

# ctf usage
alias xb64d='xsel -ob 2>/dev/null | base64 -d'
alias xb64="xsel -ob 2>/dev/null | base64"

alias windows="mount.ntfs /dev/sda3 /mnt/"

alias qemu="qemu-system-x86_64"
alias mine="cd ~/code/git/mine"
alias ssr="electron-ssr"
alias ls="exa"
