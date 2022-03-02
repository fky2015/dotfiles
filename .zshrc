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
# It includes $PATH so that we source it before `.local.zsh`.
source "$HOME/.exports.zsh"

# Create `local.zsh` if it doesn't exist.
if [ ! -f "$HOME/.local.zsh" ]; then
  cp $HOME/.local.example.zsh $HOME/.local.zsh
fi
# Any other customizations only available to local.
source "$HOME/.local.zsh"

# Zinit comfig.
source "$HOME/.zinit.zsh"

# All self-defined functions.
source "$HOME/.functions.zsh"

# All self-defined aliases.
source "$HOME/.aliases.zsh"

# p10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ZSH Profiling
#zprof
