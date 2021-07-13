final: prev: {
  dejavu-nerdfont = final.nerdfonts.override {
    fonts = [ "DejaVuSansMono" ];

  };
  gotop = final.callPackage ./gotop.nix { };
}
