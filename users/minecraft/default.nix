{ pkgs, ... }:

# user account for minecraft.

{
  home-manager.users.minecraft = {
    imports = [
      ../profiles/autojump
      ../profiles/firefox
      ../profiles/shell/fish
      ../profiles/git
    ];

    home.stateVersion = "20.09";
  };

  users.users.minecraft = {
    isNormalUser = true;

    extraGroups = [
      "audio"
    ];

    packages = with pkgs; [
      multimc
    ];

    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
