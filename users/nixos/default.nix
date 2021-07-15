{ ... }:
{
  home-manager.users.nixos = { suites, ... }: {
    imports = suites.base;
  };

  users.users.nixos = {
    uid = 1000;
    hashedPassword = "";
    description = "default";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
