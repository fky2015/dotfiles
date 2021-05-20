export LS_COLORS=$LS_COLORS:'di=0;35:'

export VISUAL=nvim
export EDITOR="$VISUAL"

export GPG_TTY=$(tty)


# for rust ./cargo/bin
export PATH="${HOME}/.cargo/bin:$PATH"

export PATH="~/.local/bin:$PATH"

# gopath
export GOPATH=~/code/go
#export GOROOT="~/.go"
export PATH="$PATH:$GOPATH/bin"
# hyperledger fabric
export PATH="$PATH:$HOME/code/git/others/fabric/.build/bin/"

#export JAVA_HOME
export JAVA_HOME="/usr/lib/jvm/default"
export PATH="${PATH}:${JAVA_HOME}/bin"
export R2PM_DBDIR="$HOME/.local/lib/r2db"

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

# ~/.node_modules/bin
export npm_config_prefix=~/.node_modules

# NEVER CHANGE IT UNLESS YOU NOW THE DANGER
export XDG_CONFIG_HOME=${HOME}/.config

# rustup for rust
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTC_WRAPPER=sccache

export PATH="$PATH:~/Xilinx/Vivado/2019.2/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export GRADLE_USER_HOME="$HOME/.gradle"

export PATH="/opt/gcc-4.3-ls232/bin:$PATH"

# nnn
export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:nmount;v:imgview;p:preview-tui'
export NNN_FIFO=/tmp/nnn.fifo

export PATH="$PATH:$HOME/playground/nsc/mips-mti-elf/2020.06-01/bin/"

# java
export CLASSPATH=/usr/share/java/antlr-4.8-complete.jar:.
