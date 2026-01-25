{ config, lib, pkgs, ...}:

{
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;
  fwupd.enable = true;

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

  environment.systemPackages = with pkgs; [
    powertop
    acpi
    lm_sensors
  ];
}
