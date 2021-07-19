channels: final: prev: {

  __dontExport = true; # overrides clutter up actual creations

  inherit (channels.latest)
    android-studio
    brave
    cachix
    chia
    dhall
    discord
    dbeaver
    element-desktop
    gotop
    manix
    rage
    multimc
    obs-studio
    prs
    qutebrowser
    signal-desktop
    spacevim
    starship
    tipp10
    tor-browser-bundle-bin
    tup;


  haskellPackages = prev.haskellPackages.override {
    overrides = hfinal: hprev:
      let version = prev.lib.replaceChars [ "." ] [ "" ] prev.ghc.version;
      in
      {
        # same for haskell packages, matching ghc versions
        inherit (channels.latest.haskell.packages."ghc${version}")
          haskell-language-server;
      };
  };

}
