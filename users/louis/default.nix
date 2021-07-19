{ pkgs, ... }:

# My account.

{
  home-manager.users.louis = {
    imports = [
      ../profiles/autojump
      ../profiles/android-development
      ../profiles/browserpass
      ../profiles/brave
      ../profiles/direnv
      ../profiles/firefox
      ../profiles/firefox/captive-browser
      ../profiles/git
      ../profiles/gnome/shell.nix
      ../profiles/gnome/yaru.nix
      ../profiles/nix-index
      ../profiles/shell/bash
      ../profiles/shell/fish
      ../profiles/spacevim
      ../profiles/ssh
      ../profiles/xcape
    ];

    home.stateVersion = "20.09";
  };

  users.users.louis = {
    isNormalUser = true;

    uid = 1001;
    extraGroups = [
      "wheel"
      "lpadmin"
      "nitrokey"
      "usbblaster"
      "tor"
      "transmission"
      "audio"
      "wireshark"
      "networkmanager"
      "lxd"
      "docker"
      "vboxusers"
      "libvirtd"
    ];

    openssh.authorizedKeys.keyFiles = [
      ./id_gpgcard.pub
    ];

    hashedPassword = "";

    packages = with pkgs; [
      element-desktop
      ffmpeg-full
      multimc
      tipp10
      virt-manager
      youtube-dl
    ];

    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
