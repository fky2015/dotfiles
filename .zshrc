# ZSH Profiling
#zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# More history,
# See: https://github.com/bamos/zsh-history-analysis/blob/master/README.md#increasing-the-history-file-size
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
# Preventing command with leading space being store in history,
# used for sensitive command.
setopt HIST_IGNORE_SPACE

# Vim emulation.
bindkey -v

# All export's.
source "$HOME/.exports.zsh"

# for tilix terminal eluminator
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

if [ ! -f "$HOME/.local.zsh" ]; then
  cat >> "$HOME/.local.zsh" << EOF
# Change to suit your needs.

# If the network is whin CN.
export DC_CN=true
# If the server is a remote server.
export REMOTE_SERVER=true
EOF
fi

source "$HOME/.local.zsh"

# Zinit comfig.
source "$HOME/.zinit.zsh"

# All self-defined functions.
source "$HOME/.functions.zsh"

# SDKMan 
#[[ -s "~/.sdkman/bin/sdkman-init.sh" ]] && source "~/.sdkman/bin/sdkman-init.sh"

# All self-defined aliases.
source "$HOME/.aliases.zsh"

# p10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ZSH Profiling
#zprof
