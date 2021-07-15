{ profiles, suites, ... }: {
  imports =
    suites.base ++
    [
      ./hardware-configuration.nix
      profiles.daemons.chia-harvester
    ];

  environment.minimalize.enable = true;
  environment.minimalize.fakeSudo = true;

  swapDevices = [{
    device = "/var/swapfile";
    size = 8192;
    randomEncryption.enable = true;
  }];

  programs.captive-browser.interface = "wlan0";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
