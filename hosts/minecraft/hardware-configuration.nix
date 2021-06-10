# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "mode=755" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/2b6826a5-0c78-45c4-84ea-f965e5238647";
      fsType = "btrfs";
      options = [ "subvol=boot" ];
    };

  fileSystems."/persist" =
    {
      device = "/dev/disk/by-uuid/2b6826a5-0c78-45c4-84ea-f965e5238647";
      fsType = "btrfs";
      options = [ "subvol=persist" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/2b6826a5-0c78-45c4-84ea-f965e5238647";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  swapDevices = [ ];

}