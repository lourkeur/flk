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
      ../profiles/fish
      ../profiles/git
      ../profiles/gnome/shell.nix
      ../profiles/gnome/yaru.nix
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

    hashedPassword = "$6$nZVlYP4/z34a$abhkQIZS6udFg6H/w2q4P37SsWDhaL0tEeDMfWqO2BbBs4NOI0lbIDXjhvs1l058YSSYOAyecRiaAByNywDO91";

    packages = with pkgs; [
      element-desktop
      multimc
      nixpkgs-fmt
      tipp10
    ];

    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
