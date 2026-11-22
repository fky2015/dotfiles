### Added by Zplugin's installer
if [[ -f "$HOME/.zinit/bin/zinit.zsh"  ]]; then
  source "$HOME/.zinit/bin/zinit.zsh"
else
  source "$HOME/.local/share/zinit/zinit.git/zinit.zsh" 
fi
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zplugin installer's chunk

zinit ice depth='1'
zinit load zdharma-continuum/zinit-annex-readurl

# z-a-bin-gem-node
zinit light zdharma-continuum/zinit-annex-bin-gem-node

z_lucid() {
	zinit ice lucid ver'master' "$@"
}

zi0a() {
	z_lucid wait'0a' "$@"
}

zi_program() {
	zi0a as'program' "$@"
}

# 快速目录跳转
zinit ice lucid wait='1' depth='1'
zinit light skywind3000/z.lua

# Load highlighting after other wait=0 plugins, initializing completions once.
zinit ice lucid wait='0c' atinit='zicompinit; zicdreplay'
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice lucid depth='1' wait='0'
zinit load MichaelAquilina/zsh-you-should-use

# 自动建议
zinit ice lucid wait="0"
zinit light zsh-users/zsh-autosuggestions

# 补全
zi for \
    blockf \
    lucid \
    wait \
  zsh-users/zsh-completions \
  nix-community/nix-zsh-completions

# 加载 OMZ 框架及部分插件
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit wait lucid for \
  OMZP::extract \
  OMZP::docker-compose \
  OMZP::docker/docker.plugin.zsh

# Load shell integration from the installed fzf.
if (( $+commands[fzf] )); then
  eval "$(fzf --zsh)"

  # Keep history search on fzf after OMZ key bindings are loaded.
  bindkey -M emacs '^R' fzf-history-widget
  bindkey -M viins '^R' fzf-history-widget
  bindkey -M vicmd '^R' fzf-history-widget
fi

# == forgit
forgit_add=gai
forgit_diff=gdi
forgit_log=glgi
forgit_checkout_commit=gcoi

zinit wait="0" lucid light-mode for \
    hlissner/zsh-autopair \
    wfxr/forgit 

zinit wait'1' lucid for \
  atload'zicdreplay' \
    OMZP::colored-man-pages \
  as"completion" atload'zicdreplay' \
    OMZP::kubectl

# zinit ice as"completion"
# zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# nnn cd on quit
# see: https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.bash_zsh
zinit ice pick"misc/quitcd/quitcd.bash_zsh"
zinit load jarun/nnn

# kubectl-aliasis
# see: https://github.com/ahmetb/kubectl-aliases
zinit ice wait'0' lucid pick".kubectl_aliases"
zinit light ahmetb/kubectl-aliases

## Git extension

# git-open has a manpage that I want in my MANPATH
zi_program has'git' atclone"cp git-open.1.md $HOME/.local/man/man1/git-open.1" atpull'%atclone'
zinit light paulirish/git-open

zinit as"null" wait"1" lucid for \
    sbin    Fakerr/git-recall \
    sbin    paulirish/git-recent \
    sbin    davidosomething/git-my \
    sbin atload"export _MENU_THEME=legacy" \
            arzzen/git-quick-stats \
    sbin    iwata/git-now \
    make"PREFIX=$ZPFX install" \
            tj/git-extras \
    sbin"bin/git-dsf;bin/diff-so-fancy" \
            zdharma-continuum/zsh-diff-so-fancy \
   sbin"git-url;git-guclone" make"GITURL_NO_CGITURL=1" \
            zdharma-continuum/git-url

# 加载 pure 主题
# zinit light romkatv/powerlevel10k

zinit light spaceship-prompt/spaceship-prompt
