{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # Standard .config/directory
  configs = {
    # i3 = "i3";
    kitty = "kitty";
    nvim = "nvim";
    # lxqt = "lxqt";
    sway = "sway";
    swaylock = "swaylock";
    kanshi = "kanshi";
    tmux = "tmux";
    waybar = "waybar";
  };
in

{
  home.username = "kerim";
  home.homeDirectory = "/home/kerim";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos/#balkan";
    };
    initExtra = ''
      	  export PS1="\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]"
      	'';
  };

  programs.git = {
    enable = true;
    userName = "kerimcanbalkan";
    userEmail = "kerimcanbalkan@gmail.com";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

   programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  services.mako = {
    enable = true;
    settings = {
      font = "JetBrains Mono 10";
      background-color = "#282828";
    };
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    tmux
    fd
    fzf
    lua
    stylua
    lua-language-server
    typescript
    typescript-language-server
    vscode-langservers-extracted
    astro-language-server
    go
    gopls
    goimports-reviser
    gofumpt
    golines
    tree-sitter
    nixpkgs-fmt
    ripgrep
    nil
    nodejs_24
    wget
    gcc
    signal-desktop
    discord
    qutebrowser
  ];

}
