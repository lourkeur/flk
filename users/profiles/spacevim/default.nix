{ pkgs, ... }:

# TODO: keeping spacevim in-sync w/ nixpkgs trunk is highly suboptimal
let spacevim = pkgs.callPackage ./pkg { };
in
{
  home.packages = [ spacevim ];
}
