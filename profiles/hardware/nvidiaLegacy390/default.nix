{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
}
