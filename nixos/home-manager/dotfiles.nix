{ config, ... }:

let
  mkOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configDir = "${config.home.homeDirectory}/dotfiles";
in
{
  home.file = {
    ".config/hypr".source = mkOutOfStoreSymlink "${configDir}/hypr";
    ".config/kanshi".source = mkOutOfStoreSymlink "${configDir}/kanshi";
    ".config/tmux".source = mkOutOfStoreSymlink "${configDir}/tmux";
    ".config/nvim".source = mkOutOfStoreSymlink "${configDir}/nvim";
    ".config/waybar".source = mkOutOfStoreSymlink "${configDir}/waybar";
    ".config/emacs".source = mkOutOfStoreSymlink "${configDir}/emacs";
    ".config/swaync".source = mkOutOfStoreSymlink "${configDir}/swaync";
  };
}
