{
  environment.persistence."/persist" = {
    directories = [
      "/var/db/sudo"
      "/var/log"
      "/var/lib/libvirt"
      "/var/lib/lxc"
      "/var/lib/lxd"
      "/var/lib/systemd/coredump"
      "/var/lib/transmission"
      "/var/tmp"
      "/etc/ssh"
      "/etc/miniguests"
    ];
    files = [
      "/etc/nix/key.private"
    ];
  };
  fileSystems."/persist".neededForBoot = true;
}
