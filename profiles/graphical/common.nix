{ config, lib, pkgs, ... }:

{
  boot.plymouth.enable = true;

  services.xserver.enable = true;

  environment.systemPackages = with pkgs; [
    gimp
    libreoffice-still
    tdesktop
    thunderbird
    nixos-artwork.wallpapers.simple-red
  ] ++ lib.optionals (pkgs.system == "x86_64-linux") [
    obs-studio
    tor-browser-bundle-bin
  ];

  programs.browserpass.enable = true;

  programs.wireshark.package = pkgs.wireshark; # w/ qt interface
}
