{ pkgs, ... }:

# sign every built derivation with a machine-local key.
# generate with
# sudo nix-store --generate-binary-cache-key $(hostname) /etc/nix/key.{private,public}
# and add public key in the core/trusted-machines profile
let
  postBuildHook = pkgs.writers.writeDash "sign-paths"  ./sign-paths.sh;
in
{
  nix.extraOptions = "post-build-hook = ${postBuildHook}";
}
