{ config, pkgs, ... }:

let
my-python-packages = ps: with ps; [
    pandas
    numpy
    requests
    virtualenv
    psutil
  ];
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "fengkaiyu.hi";
  home.homeDirectory = "/home/fengkaiyu.hi";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    #
    # Basic CLI tools.
    exa
    bat
    fd
    difftastic
    tokei
    tealdeer
    xsv
    fzf
    du-dust
    hexyl
    hyperfine

    # Overview
    htop
    glances
    neofetch

    # Development
    direnv
    neovim
    tree-sitter
    tmux
    jq
    nnn
    git-crypt
    yadm
    rlwrap
    vim
    helix
    gitui
    rr
    lz4

    # Files
    zstd
    restic
    neofetch

    # Develop environment
    fnm
    sqlite
    clang-tools_16
    mold
    lld_16
    gcc12
    (python310.withPackages my-python-packages)
    sccache
    # gcc_debug
    # llvmPackages_16.clangNoLibcxx
    # python311
    # python311Packages.pip

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/fengkaiyu.hi/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
