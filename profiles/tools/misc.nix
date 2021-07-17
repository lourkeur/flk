{ lib, config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      ffmpeg-full
      tup
      youtube-dl
      binutils
      clinfo
      coreutils
      curl
      direnv
      dnsutils
      dosfstools
      fd
      file
      git
      glxinfo
      gotop
      gptfdisk
      iputils
      jq
      less
      libarchive
      manix
      miniguest
      moreutils
      nix-index
      nmap
      pass-otp
      pciutils
      prs
      python3
      qrencode
      ripgrep
      skim
      tealdeer
      usbutils
      utillinux
      whois
    ];

    shellAliases = {
      # libarchive's bsdtar (multi-format archive)
      tar = "bsdtar";

      # manix
      mn = ''
        manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | sk --preview="manix '{}'" | xargs manix
      '';

      # git
      g = "git";

      # ripgrep
      grep = "rg";

      # gotop
      top = "gotop";

      # Python
      py = "python3";
    };
  };
}
