{ profiles, suites, ... }:

{
  imports =
    suites.base ++
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      profiles.users.minecraft
      profiles.tools.jdk
      profiles.daemons.tor
    ];

  # Use miniguest
  boot.loader.grub.enable = false;
  boot.miniguest.enable = true;

  networking.hostName = "minecraft"; # Define your hostname.

  environment.persistence."/persist" = {
    directories = [
      "/var/log"
      "/var/lib/systemd/coredump"
      "/home/minecraft/.local/share/multimc"
      "/home/minecraft/.config/lxqt"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_rsa_key"
    ];
  };
  fileSystems."/persist".neededForBoot = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;

  nix.allowedUsers = [ "minecraft" ];

  services.autoLogin.user = "minecraft";

  services.btrfs.autoScrub = {
    enable = true;
    interval = "Sun 03:15";
  };

  services.xserver.enable = true;
  services.xserver.desktopManager.lxqt.enable = true;

  users.mutableUsers = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "21.05"; # Did you read the comment?

}
