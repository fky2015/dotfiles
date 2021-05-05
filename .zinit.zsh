### Added by Zplugin's installer
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zplugin installer's chunk

zinit ice depth='1'
zinit load zinit-zsh/z-a-readurl

# 快速目录跳转
zinit ice lucid wait='1' depth='1'
zinit light skywind3000/z.lua

# Plugin history-search-multi-word loaded with investigating.
zinit ice depth='1'
zinit load zdharma/history-search-multi-word

# 语法高亮
zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma/fast-syntax-highlighting

# 自动建议
zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# 补全
zinit ice lucid wait='0'
zinit light zsh-users/zsh-completions

# 加载 OMZ 框架及部分插件
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

zinit ice svn
zinit snippet OMZ::plugins/extract

zinit ice lucid wait='1'
zinit snippet OMZ::plugins/git/git.plugin.zsh
#zinit snippet OMZ::plugins/docker/_docker
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

# z-a-bin-gem-node
zinit light zinit-zsh/z-a-bin-gem-node


# nnn cd on quit
# see: https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.bash_zsh
zinit ice pick"misc/quitcd/quitcd.bash_zsh"
zinit load jarun/nnn

# Git extension

zinit as"null" wait"1" lucid for \
    sbin    Fakerr/git-recall \
    sbin    cloneopts paulirish/git-open \
    sbin    paulirish/git-recent \
    sbin    davidosomething/git-my \
    sbin atload"export _MENU_THEME=legacy" \
            arzzen/git-quick-stats \
    sbin    iwata/git-now \
    make"PREFIX=$ZPFX install" \
            tj/git-extras \
    sbin"bin/git-dsf;bin/diff-so-fancy" \
            zdharma/zsh-diff-so-fancy \
   sbin"git-url;git-guclone" make"GITURL_NO_CGITURL=1" \
            zdharma/git-url

# 加载 pure 主题
zplugin ice depth=1; zinit light romkatv/powerlevel10k
