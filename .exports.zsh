export VISUAL=nvim
export EDITOR="$VISUAL"

export GPG_TTY=$(tty)

export PATH="$HOME/.local/bin:$PATH"

# gopath
export GOPATH=$HOME/code/go
#export GOROOT="~/.go"
export PATH="$GOPATH/bin:$PATH"

#export JAVA_HOME
export JAVA_HOME="/usr/lib/jvm/default"
export PATH="$JAVA_HOME/bin:$PATH"

# FZF
export FZF_DEFAULT_OPTS="--height 70% --layout=reverse --preview '(bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -500'"
export FZF_DEFAULT_COMMAND='rg --files'

# miniconda
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# elixir
export HEX_MIRROR="https://hexpm.upyun.com"
export HEX_CDN="https://hexpm.upyun.com"

# install npm package in User dir
export PATH="$HOME/.node_modules/bin:$PATH"

# NEVER CHANGE IT UNLESS YOU NOW THE DANGER
export XDG_CONFIG_HOME=$HOME/.config

# rustup for rust
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTC_WRAPPER=sccache

# nnn
export NNN_OPTS='Ta'
export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:nmount;v:imgview;p:preview-tui'
export NNN_FIFO=/tmp/nnn.fifo
BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
