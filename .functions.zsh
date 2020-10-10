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


# Shell
b64() { echo -n $1 | base64 }
b64d() { echo -n $1 | base64 -d}

set_proxy() {
    export http_proxy=socks5://localhost:1080
    export https_proxy=socks5://localhost:1080
}

unset_proxy(){
    unset http_proxy
    unset https_proxy
}

nasm-bin() { nasm $1.asm -f bin -o $1.bin }

function take() {
  mkdir -p $@ && cd ${@:$#}
}


