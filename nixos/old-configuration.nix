{ config, pkgs, callPackage, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.consoleLogLevel = 3;

  boot.initrd.luks.devices."luks-82a289ea-29a2-4cdb-a657-42ddfe53434e".device = "/dev/disk/by-uuid/82a289ea-29a2-4cdb-a657-42ddfe53434e";
  networking.hostName = "balkan";

  # Enable networking
  networking.networkmanager.enable = true;

  # Disable NetworkManager's internal DNS resolution
  networking.networkmanager.dns = "none";

  # Disable firewall
  networking.firewall.enable = false;

  # These options are unnecessary when managing DNS ourselves
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;
  networking.enableIPv6 = false;

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "8.8.8.8"
    "8.8.4.4"
  ];

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        ControllerMode = "bredr";
      };
    };
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "lock";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "ignore";
  };

  services.blueman.enable = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"]; 

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["intel"];

  services.libinput = {
    enable = true;
    touchpad = {
      disableWhileTyping = true;
    };
  };

  # Enable the X11 windowing system.
  # services.xserver = {
  #     enable = true;
  #     autoRepeatDelay = 200;
  #     autoRepeatInterval = 35;
  #     displayManager.lightdm = {
  #       enable = true;
  #       background = "/usr/share/background/luffy.jpg";
  #       greeters.slick.enable = true;
  #       greeters.slick.draw-user-backgrounds = true;
  #   };
  #     displayManager.sessionCommands = ''${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --scale 0.8x0.8'';
  #     desktopManager.lxqt.enable = true;
  #     windowManager.i3.enable = true;
  #     xkb.layout = "us";
  #     xkb.variant = "";
  #     xkb.options = "ctrl:nocaps";
  # };
  
  
  programs.sway = {              
    enable = true;               
    xwayland.enable = true;      
    extraPackages = with pkgs; [ 
      swaylock-effects           
      swayidle                   
      autotiling                 
      wmenu                      
      waybar                     
      wl-clipboard               
      wf-recorder                
      kanshi                     
      brightnessctl              
      imv                        
      mpv                        
      zathura                    
      mupdf
      mako                       
      grim                       
      slurp                      
      w3m                        
      vlc
      imagemagick                
      lf                         
      libreoffice-fresh          
    ];                           
  };                             
  

  services.displayManager.ly = {
    enable = true;
    settings = {
      save = true;
    };
  };

  services.thermald.enable = true;

  # Autocpufreq power manager

  programs.auto-cpufreq.enable = true;
  # optionally, you can configure your auto-cpufreq settings, if you have any
  programs.auto-cpufreq.settings = {
    charger = {
      governor = "performance";
      turbo = "auto";
    };

    battery = {
      governor = "powersave";
      turbo = "auto";
      energy_performance_preference = "power";
      enable_thresholds = true;
      start_threshold = 30;
      stop_threshold = 80;
    };
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kerim = {
    isNormalUser = true;
    description = "Kerimcan Balkan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  programs.foot = {
    enable = true;
    theme = "gruvbox-dark";
    settings =  {
      main = {
        font = "Aporetic Sans Mono:size=13";
        pad = "10x10";
      };
      scrollback = {
        lines = 100000;
      };
      colors = {
        alpha = 0.9;
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.fwupd.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.departure-mono
    nerd-fonts.gohufont
    nerd-fonts.jetbrains-mono
    nerd-fonts.geist-mono
    nerd-fonts.hack
    freefont_ttf
    aporetic
  ];

  # Enable automatic mounting of USB drives
  services.udisks2.enable = true;

  services.pcscd.enable = true;
  programs.gnupg.agent = {
     enable = true;
     pinentryPackage = pkgs.pinentry-qt;
     enableSSHSupport = true;
   };

  environment.systemPackages = with pkgs; [
    vim 
    gcc
    gnumake
    bat
    unzip
    pinentry-qt
    kitty
    gimp
    inkscape
    # librewolf causes infinite 
    ungoogled-chromium
    libvterm
  ];

  system.stateVersion = "25.05";
}
