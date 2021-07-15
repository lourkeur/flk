{ lib, config, pkgs, ... }:

{
  boot.binfmt.emulatedSystems = lib.lists.remove pkgs.system [ "aarch64-linux" ];

  environment = {
    systemPackages = with pkgs; [
      ffmpeg-full
      tup
      youtube-dl
      binutils
      coreutils
      curl
      direnv
      dnsutils
      dosfstools
      fd
      file
      git
      gptfdisk
      gotop
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
