{ config, pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages =
      epkgs: with epkgs; [
        vterm
        treesit-grammars.with-all-grammars
        mu4e
      ];
  };


  # Add the systemd user service
  systemd.user.services.emacs = {
    Unit = {
      Description = "Emacs daemon";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "notify";
      ExecStart = "${config.programs.emacs.finalPackage}/bin/emacs --fg-daemon";
      ExecStop = "${config.programs.emacs.finalPackage}/bin/emacsclient --eval '(kill-emacs)'";
      Restart = "on-failure";

      Environment = [
        "PATH=${config.home.profileDirectory}/bin:/run/current-system/sw/bin"
        "XDG_CURRENT_DESKTOP=Hyprland"
        "XDG_SESSION_TYPE=wayland"
      ];
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
