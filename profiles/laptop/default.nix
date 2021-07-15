{ lib, ... }:

{
  programs.captive-browser = {
    enable = true;
    # placeholder so nix flake check can build the profile
    interface = lib.mkDefault "";
  };
}
