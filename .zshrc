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

# https://github.com/larkery/zsh-histdb
_zsh_autosuggest_strategy_histdb_top_here() {
    emulate -L zsh
    (( $+functions[_histdb_query] && $+builtins[zsqlite_exec] )) || return
    _histdb_init
    local last_cmd="$(sql_escape ${history[$((HISTCMD-1))]})"
    local cmd="$(sql_escape $1)"
    local pwd="$(sql_escape $PWD)"
    local reply=$(zsqlite_exec _HISTDB "
SELECT argv FROM (SELECT * FROM (
  SELECT c1.argv, p1.dir, h1.session, h1.start_time, 1 AS priority
  FROM history h1, history h2
    LEFT JOIN commands c1 ON h1.command_id = c1.ROWID
    LEFT JOIN commands c2 ON h2.command_id = c2.ROWID
    LEFT JOIN places p1   ON h1.place_id = p1.ROWID
  WHERE h1.ROWID = h2.ROWID + 1
    AND c1.argv LIKE '$cmd%'
    AND c2.argv = '$last_cmd'
) UNION SELECT * FROM (
  SELECT c1.argv, p1.dir, h1.session, h1.start_time, 0 AS priority
  FROM history h1
    LEFT JOIN commands c1 ON h1.command_id = c1.ROWID
    LEFT JOIN places p1   ON h1.place_id = p1.ROWID
  WHERE c1.argv LIKE '$cmd%'
))
ORDER BY dir != '$pwd', priority DESC, session != $HISTDB_SESSION, start_time DESC
LIMIT 1
")
    typeset -g suggestion=$reply
}
ZSH_AUTOSUGGEST_STRATEGY=(histdb_top_here match_prev_cmd completion)

# p10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ZSH Profiling
#zprof
