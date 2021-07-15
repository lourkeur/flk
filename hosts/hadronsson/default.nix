{ profiles, suites, ... }:

{
  imports =
    suites.laptop ++
    suites.gnome ++
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      profiles.hardware.persistence
      profiles.tools.teck-programmer
      profiles.daemons.libvirt
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "hadronsson"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp3s0f2.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  # For WiFi card
  hardware.enableRedistributableFirmware = true;
  programs.captive-browser.interface = "wlp2s0";

  services.btrfs.autoScrub = {
    enable = true;
    interval = "Sun 03:15";
  };

  users.mutableUsers = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}
