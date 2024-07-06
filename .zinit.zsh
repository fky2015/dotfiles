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

# 安装二进制软件

# See ~/.local.zsh for more.
if [[ "$ZINIT_DOWNLOAD_BIN" == "foo" ]] 
then
  # direnv
  zinit from"gh-r" as"program" mv"direnv* -> direnv" \
      atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
      pick"direnv" src="zhook.zsh" for \
          direnv/direnv

  # fzf, fd, bat, exa using the for-syntax and also z-a-bin-gem-node annex
  zinit wait"1" lucid from"gh-r" as"null" for \
       sbin"fzf"          junegunn/fzf \
       sbin"**/fd"        @sharkdp/fd \
       sbin"**/bat"       @sharkdp/bat \
       sbin"exa* -> exa"  ogham/exa
  
fi

# jarun/nnn, a file browser, using the for-syntax
zinit pick"misc/quitcd/quitcd.zsh" sbin make light-mode for jarun/nnn

# 快速目录跳转
zinit ice lucid wait='1' depth='1'
zinit light skywind3000/z.lua

# Plugin history-search-multi-word loaded with investigating.
zinit ice depth='1'
zinit load zdharma-continuum/history-search-multi-word

# 语法高亮
zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice depth='1'
zinit load MichaelAquilina/zsh-you-should-use

# 自动建议
zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# 补全
zi for \
    atload"zicompinit; zicdreplay" \
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
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit snippet OMZ::plugins/aws/aws.plugin.zsh

zinit snippet OMZ::plugins/git/git.plugin.zsh

# zinit light RobertDeRose/virtualenv-autodetect

# zinit ice nocompletions
# zinit light Aloxaf/zsh-sqlite

# == forgit
forgit_add=gai
forgit_diff=gdi
forgit_log=glgi
forgit_checkout_commit=gcoi

zinit wait="0" lucid light-mode for \
    hlissner/zsh-autopair \
    wfxr/forgit 

zinit ice svn
zinit snippet OMZ::plugins/extract

zinit ice lucid wait='1'
zinit wait lucid for \
  atinit"zicompinit; zicdreplay"  \
    OMZP::colored-man-pages \
  as"completion" \
    OMZP::kubectl

zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# nnn cd on quit
# see: https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.bash_zsh
zinit ice pick"misc/quitcd/quitcd.bash_zsh"
zinit load jarun/nnn

# kubectl-aliasis
# see: https://github.com/ahmetb/kubectl-aliases
zinit ice pick".kubectl_aliases"
zinit load ahmetb/kubectl-aliases

# fzf shell extension
# see: https://github.com/junegunn/fzf/blob/master/shell/
# zinit ice multisrc'shell/{completion,key-bindings}.zsh'
# zinit load junegunn/fzf
# https://github.com/zdharma-continuum/zinit/discussions/359
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search
# zinit ice wait lucid from"gh-r" nocompile src'shell/key-bindings.zsh' sbin \
#       dl'https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh -> _fzf_completion;
#          https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh -> key-bindings.zsh;
#          https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1 -> $ZPFX/share/man/man1/fzf-tmux.1;
#          https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1 -> $ZPFX/share/man/man1/fzf.1'
# zinit light junegunn/fzf



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

zinit ice as"program" cp"wd.sh -> wd" mv"_wd.sh -> _wd" \
    atpull'!git reset --hard' pick"wd"
zinit light mfaerevaag/wd

# 加载 pure 主题
zplugin ice depth=1; zinit light romkatv/powerlevel10k
