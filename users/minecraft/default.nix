{ pkgs, ... }:

# unprivileged user account for playing Minecraft.

{
  home-manager.users.minecraft = { profiles, ... }: {
    imports = with profiles;[
      autojump
      firefox
      shell.fish
      git
      xcape
    ];

    home.stateVersion = "20.09";
  };

  users.users.minecraft = {
    isNormalUser = true;
    uid = 2039;

    extraGroups = [
      "audio"
    ];

    hashedPassword = "";

    packages = with pkgs; [
      multimc
    ];

    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
