#!/bin/zsh

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# If is Linux, then use, alias `open` to `xdg-open`.
if [[ $machine == "Linux" ]]; then
  alias open="xdg-open"
fi

# Basic
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
alias zinitrc="$VISUAL ~/.zinit.zsh"
alias vimrc="$VISUAL ~/.vimrc"
alias nvimrc="cd ~/.config/astronvim && nvim . && cd -"
alias ipad="ip addr | grep inet && hostname -i"
alias cdp="cd ~/playground" # change to the playground
alias cdd="cd ~/Downloads" # change to the Downloads
alias cdo="cd ~/Documents/onedrive"
alias tt="take ~/playground/$(date -u '+%m%d')"
alias h="htop"
alias nv="nvim"
alias nv.="nvim ."
alias nvc="nvim --clean -u $HOME/.config/nvim/lua/fky/options.lua"
alias nvim="NVIM_APPNAME=astronvim nvim"
alias anv="anvim"
alias v="vim"
alias n="nnn"

# Onedrive
alias one="onedrive --synchronize"
alias one-d="onedrive --monitor --verbose"
# only backup, never delete remotely
alias oned='onedrive --synchronize --confdir="~/.config/onedriveEdu" --upload-only --no-remote-delete'

alias cdg="cd ~/Documents/gdrive"
alias p="pwd" # shorter
# alias tmux="tmux -2" # fix the problem with vim
alias ta="tmux a"
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
alias cdi="cd ~/code/incubators"
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
alias ls="eza"
alias ll="eza -al"

# LaTeX
# https://wiki.archlinux.org/title/TeX_Live
alias tlmgr="/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode"

# Rust
alias cb="cargo b"
alias cbr="cargo b --release"
alias de="direnv edit"
alias sp="set_proxy"
alias usp="unset_proxy"

# Nix
alias home="nvim $HOME/.config/home-manager/home.nix"

# Github Copilot CLI
  copilot_what-the-shell () {
    TMPFILE=$(mktemp);
    trap 'rm -f $TMPFILE' EXIT;
    if github-copilot-cli what-the-shell "$@" --shellout $TMPFILE; then
      if [ -e "$TMPFILE" ]; then
        FIXED_CMD=$(cat $TMPFILE);
        print -s "$FIXED_CMD";
        eval "$FIXED_CMD"
      else
        echo "Apologies! Extracting command failed"
      fi
    else
      return 1
    fi
  };
alias '??'='copilot_what-the-shell';

  copilot_git-assist () {
    TMPFILE=$(mktemp);
    trap 'rm -f $TMPFILE' EXIT;
    if github-copilot-cli git-assist "$@" --shellout $TMPFILE; then
      if [ -e "$TMPFILE" ]; then
        FIXED_CMD=$(cat $TMPFILE);
        print -s "$FIXED_CMD";
        eval "$FIXED_CMD"
      else
        echo "Apologies! Extracting command failed"
      fi
    else
      return 1
    fi
  };
alias 'git?'='copilot_git-assist';

  copilot_gh-assist () {
    TMPFILE=$(mktemp);
    trap 'rm -f $TMPFILE' EXIT;
    if github-copilot-cli gh-assist "$@" --shellout $TMPFILE; then
      if [ -e "$TMPFILE" ]; then
        FIXED_CMD=$(cat $TMPFILE);
        print -s "$FIXED_CMD";
        eval "$FIXED_CMD"
      else
        echo "Apologies! Extracting command failed"
      fi
    else
      return 1
    fi
  };
alias 'gh?'='copilot_gh-assist';
alias 'wts'='copilot_what-the-shell';
