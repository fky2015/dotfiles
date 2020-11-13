# ZSH Profiling
#zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# All export's.
source "$HOME/.exports.zsh"

# for tilix terminal eluminator
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
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
