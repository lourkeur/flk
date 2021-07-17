# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ profiles, suites, ... }:

{
  imports =
    suites.workstation ++
    suites.gnome ++
    suites.buildServer ++
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      profiles.torbox
      profiles.daemons.libvirt
      profiles.daemons.lxd
      profiles.daemons.transmission
      profiles.daemons.chia-wallet
      profiles.hardware.persistence
    ];

  specialisation.nvidia.configuration.imports = [
    profiles.hardware.nvidiaLegacy390
  ];

  # GRUB
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub.efiInstallAsRemovable = true;

  boot.initrd.kernelModules = [ "dm-raid" ];

  networking.hostName = "hadron"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;

  # Aliases for imperative guests.
  networking.hosts."192.168.122.38" = [ "minecraft" ];

  hardware.nvidia.prime = {
    intelBusId = "PCI:00:02:0";
    nvidiaBusId = "PCI:01:00:0";
  };

  users.mutableUsers = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
