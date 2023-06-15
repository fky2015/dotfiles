if [ -e "$HOME/.cargo/env" ]; then . "$HOME/.cargo/env"; fi

export GPG_TTY=$(tty)

if [ -e /home/fengkaiyu.hi/.nix-profile/etc/profile.d/nix.sh ]; then . /home/fengkaiyu.hi/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

