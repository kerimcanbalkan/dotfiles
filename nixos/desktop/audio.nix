{ config, pkgs, ... }:
{
  # Disable PulseAudio in favor of PipeWire
  services.pulseaudio.enable = false;

  # Enable real-time audio support
  security.rtkit.enable = true;

  # PipeWire configuration
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Audio packages
  environment.systemPackages = with pkgs; [
    pavucontrol
    playerctl
    wireplumber
    alsa-utils
  ];
}
