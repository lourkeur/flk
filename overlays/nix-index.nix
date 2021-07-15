final: prev: {
  nix-index = prev.nix-index.override { nix = final.nixFlakes; };
}
