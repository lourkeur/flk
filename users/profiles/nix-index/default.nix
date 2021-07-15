{ pkgs, ... }:

{
  programs.nix-index.enable = true;

  home.file.".cache/nix-index/".source = pkgs.requireFile {
    name = "nix-index.2021-07-15";
    sha256 = "sha256-Jg0aKxOn7SKmIDWWwM5Oq695Zmf7fKfuclHzHgyX6A4=";
    hashMode = "recursive";
    message = ''
      Please build a fresh nix-index with

      nix-index -d nix-index.`date +%F`
      nix store add-path nix-index.`date +%F`
      nix hash path nix-index.`date +%F`  # report in the derivation
      rm -r nix-index.`date +%F`
    '';
  };
}
