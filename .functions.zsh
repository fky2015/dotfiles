# Pastebin
PB_HOST="https://fars.ee"

pb() {
  emulate -L zsh
  case $1 in
    --rec)
      asciinema rec /tmp/$$.json
      local url=$(pb_core < /tmp/$$.json)
      print "${${url%/json}/.ee/.ee/t}"
      ;;
    --tmux)
      tmux capture-pane -J -p | pb_core
      ;;
    --delete)
      if [[ ! -f ~/.cache/pb/$2 ]]; then
        print "$2 doesn't exists!"
        return 1
      fi
      local -A info=(${(@s/: /)${${(f)"$(<~/.cache/pb/$2)"}//$'\n'/: }})
      local uuid=$info[uuid]
      curl -X DELETE "$PB_HOST/$uuid"
      ;;
    *)
      pb_core ${*:1}
      ;;
  esac
}

pb_core() {
  local file==(<<<'')

  if (( $# == 0 )); then
    cat > $file
  else
    file=$1
  fi

  local res=${(f)"$(curl -F "c=@-" "$PB_HOST" < $file)"}
  local -A info=(${(s/: /)${res//$'\n'/: }})
  local url=$info[url]

  [[ -d ~/.cache/pb ]] || mkdir ~/.cache/pb
  print $res > ~/.cache/pb/$info[short]
 
  local mime=$(file --mime-type -b $file)
  case $mime in
    image/*)
      local type=${${file:e}:-${mime#*/}}
      print "$url.$type" ;;
    text/x-*)
      local lang=${${file:e}:-${mime#*-}}
      print "$url/$lang" ;;
    application/json)
      print "$url/json" ;;
    *) print "$url${(M)${file:t}%.*}" ;;
  esac

  (( $# == 0 )) && rm $file
}

# ghq-fzf zsh
function ghq-fzf() {
  local selected_dir=$(ghq list | fzf --query="$LBUFFER")

  if [ -n "$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi

  zle reset-prompt
}

zle -N ghq-fzf
bindkey "^]" ghq-fzf

# Shell
b64() { echo -n $1 | base64 }
b64d() { echo -n $1 | base64 -d}

set_proxy() {
    export http_proxy=http://localhost:8888
    export https_proxy=http://localhost:8888
}

unset_proxy(){
    unset http_proxy
    unset https_proxy
}

nasm-bin() { nasm $1.asm -f bin -o $1.bin }

function take() {
  mkdir -p $@ && cd ${@:$#}
}

function loop() {
  count=0
  echo "Loop $count start"
  while $@; do
    echo "Loop $count start"
    count=$((count+1))
    echo "Loop $count end"
  done
  echo "Loop $count end (exit)"
}

# Move the repo to the ghq directory according to git remote url.
hatch() {
  repo=$1
  hash ghq
  cd $repo
  git_url=`git remote -v | grep fetch | awk '{print $2}'`
  cd ..
  platform=`echo $git_url | awk -F'[:/@]' '{print $2}'`
  username=`echo $git_url | awk -F'[:/@]' '{print $3}'`
  repo_name=`echo $git_url | awk -F'[:/@]' '{print $4}' | sed 's/\.git$//'`
  dest=`ghq root`/$platform/$username

  echo "Moving $repo to $dest/$repo_name"
  read REPLY\?"Do you want to continue (y/n)?"

  # If $dest does not exist, create it.
  if [ ! -d $dest ]; then
    mkdir -p $dest
  fi

  # If $dest/$repo_name exists, prompt then abort.
  if [ -d $dest/$repo_name ]; then
    echo "$dest/$repo_name already exists."
    return 1
  fi

  if [ "$REPLY" = "y" ]; then
    mv $repo $dest/$repo_name
    cd $dest/$repo_name
  else
    echo "Aborted, please enter y to confirm."
  fi
}
