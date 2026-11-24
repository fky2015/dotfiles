#!/bin/zsh

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
    CUSTOM_HTTP_PROXY=${CUSTOM_HTTP_PROXY:-"127.0.0.1:1080"}
    export http_proxy=$CUSTOM_HTTP_PROXY
    export https_proxy=$CUSTOM_HTTP_PROXY
    if [[ ! -z $CUSTOM_NO_PROXY ]]; then
      export no_proxy=$CUSTOM_NO_PROXY
      export NO_PROXY=$CUSTOM_NO_PROXY
    fi
  
}

unset_proxy(){
    unset http_proxy
    unset https_proxy
    unset no_proxy
    unset NO_PROXY
}

nasm-bin() { nasm $1.asm -f bin -o $1.bin }

function take() {
  mkdir -p $@ && cd ${@:$#}
}

function loop() {
  set -o pipefail
  count=0
  cmds=($@)
  echo "Loop $count start"
  # If environment variable LOOP_OUTPUT is set, output the result of the command.
  if [ -n "$LOOP_OUTPUT" ]; then
    echo "Loop $count output to $LOOP_OUTPUT"
    cmds+=("| tee $LOOP_OUTPUT")
  fi

  echo "Loop commands: ${cmds[@]}"
  
  while eval ${cmds[@]}; do
    echo "Loop $count end"
      count=$((count+1))
    echo "Loop $count start"
  done
  echo "Loop $count end (exit)\n"
  set +o pipefail
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

# Select wanted template and symlink it to current dir.
link_from_template() {
  local templates_dir="$HOME/templates"
  local selected_file source_file target_file

  # Check if templates directory exists
  if [[ ! -d "$templates_dir" ]]; then
      echo "Error: Templates directory $templates_dir does not exist" >&2
      return 1
  fi

  # Check if fzf is installed
  if ! command -v fzf &>/dev/null; then
      echo "Error: fzf is required but not installed" >&2
      return 1
  fi

  # Select template using fzf
  selected_file=$(
      for source_file in "$templates_dir"/*(ND.); do
          [[ $source_file == *.sh ]] || print -r -- "${source_file:t}"
      done | fzf --height=40% --reverse --border --prompt="Select template: "
  )

  # Exit if no selection
  [[ -z "$selected_file" ]] && return 0

  source_file="$templates_dir/$selected_file"
  target_file="./$selected_file"

  # Handle existing target path. For symlinks, [[ -e ]] is false if the link is broken,
  # so use [[ -L ]] as well to avoid blindly overwriting existing symlink paths.
  if [[ -e "$target_file" || -L "$target_file" ]]; then
      if [[ -L "$target_file" && "$(readlink "$target_file")" == "$source_file" ]]; then
          echo "Target file '$target_file' is already linked to '$source_file'."
          return 0
      fi

      read -q "REPLY?Target path '$target_file' already exists. Replace it with a symlink? [y/N] "
      echo  # Move to new line after read -q
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
          echo "Skipped."
          return 0
      fi

      rm -rf -- "$target_file" || return 1
  fi

  ln -s -- "$source_file" "$target_file"
  echo "Linked '$target_file' -> '$source_file'"
}

# Select template updater script, run it, and update the paired template with stdout.
update_template_from_remote() {
  local templates_dir="$HOME/templates"
  local selected_script script_file target_file tmp_file rc

  # Check if templates directory exists
  if [[ ! -d "$templates_dir" ]]; then
      echo "Error: Templates directory $templates_dir does not exist" >&2
      return 1
  fi

  # Check if fzf is installed
  if ! command -v fzf &>/dev/null; then
      echo "Error: fzf is required but not installed" >&2
      return 1
  fi

  # Select updater script using fzf. A template like mise.toml is updated by mise.toml.sh.
  selected_script=$(
      for script_file in "$templates_dir"/*.sh(ND.); do
          print -r -- "${script_file:t}"
      done | fzf --height=40% --reverse --border --prompt="Select updater script: "
  )

  # Exit if no selection
  [[ -z "$selected_script" ]] && return 0

  script_file="$templates_dir/$selected_script"
  target_file="$templates_dir/${selected_script%.sh}"
  tmp_file=$(mktemp) || return 1

  if [[ ! -x "$script_file" ]]; then
      zsh "$script_file" > "$tmp_file"
      rc=$?
  else
      "$script_file" > "$tmp_file"
      rc=$?
  fi

  if (( rc != 0 )); then
      rm -f -- "$tmp_file"
      echo "Error: Updater '$script_file' failed with status $rc. Template not updated." >&2
      return $rc
  fi

  mv -- "$tmp_file" "$target_file"
  echo "Updated '$target_file' from '$script_file'."
}
