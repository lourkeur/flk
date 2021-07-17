{
  description = "A highly structured configuration database.";

  inputs =
    {
      nixos.url = "nixpkgs/nixos-21.05";
      latest.url = "github:lourkeur/nixpkgs";
      digga.url = "github:divnix/digga/main";

      darwin.url = "github:LnL7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "latest";
      home.url = "github:nix-community/home-manager/release-21.05";
      home.inputs.nixpkgs.follows = "nixos";
      impermanence.url = "github:nix-community/impermanence";
      miniguest.url = "github:lourkeur/miniguest";
      miniguest.inputs.nixpkgs.follows = "nixos";
      naersk.url = "github:nmattia/naersk";
      naersk.inputs.nixpkgs.follows = "latest";
      agenix.url = "github:ryantm/agenix";
      agenix.inputs.nixpkgs.follows = "latest";
      nixos-hardware.url = "github:nixos/nixos-hardware";

      pkgs.url = "path:./pkgs";
      pkgs.inputs.nixpkgs.follows = "nixos";
    };

  outputs =
    { self
    , pkgs
    , digga
    , nixos
    , home
    , impermanence
    , miniguest
    , nixos-hardware
    , nur
    , agenix
    , ...
    } @ inputs:
    digga.lib.mkFlake {
      inherit self inputs;

      channelsConfig = import nixpkgs/config.nix { inherit (nixos) lib; };

      channels = {
        nixos = {
          imports = [ (digga.lib.importers.overlays ./overlays) ];
          overlays = [
            ./pkgs/default.nix
            pkgs.overlay # for `srcs`
            nur.overlay
            agenix.overlay
          ];
        };
        latest = { };
      };

      lib = import ./lib { lib = digga.lib // nixos.lib; };

      sharedOverlays = [
        (final: prev: {
          lib = prev.lib.extend (lfinal: lprev: {
            our = self.lib;
          });
        })
        miniguest.overlay
      ];

      nixos = {
        hostDefaults = {
          system = "x86_64-linux";
          channelName = "nixos";
          modules = ./modules/module-list.nix;
          externalModules = [
            { _module.args.ourLib = self.lib; }
            home.nixosModules.home-manager
            agenix.nixosModules.age
            impermanence.nixosModules.impermanence
            miniguest.nixosModules.miniguest
            ./modules/customBuilds.nix
          ];
        };

        imports = [ (digga.lib.importers.hosts ./hosts) ];
        hosts = with nixos-hardware.nixosModules; {
          /* set host specific properties here */
          NixOS = { };
          hadron.modules = [ common-cpu-intel-sandy-bridge ];
          hadronsson.modules = [ common-cpu-intel-sandy-bridge ];
          quark.system = "aarch64-linux";
          quark.modules = [ raspberry-pi-4 ];
          rpi4-bootstrap.system = "aarch64-linux";
          rpi4-bootstrap.modules = [ raspberry-pi-4 ];
        };
        importables = rec {
          profiles = digga.lib.importers.rakeLeaves ./profiles // {
            users = digga.lib.importers.rakeLeaves ./users;
          };
          suites = with profiles; rec {
            base = [ core users.root ];
            gnome = [ graphical.common graphical.gnome ];
            allTools = builtins.attrValues tools;

            workstation = base ++ allTools ++ [
              users.louis
              users/louis/singleUser
              misc.sign-store-paths
              network.nfs
              network.printers
              network.keybase
            ];

            buildServer = [
              misc.sign-store-paths
              network.nix-build-server
              network.nix-serve
            ];
          };
        };
      };

      home = {
        modules = ./users/modules/module-list.nix;
        externalModules = [
          "${impermanence}/home-manager.nix"
        ];
        importables = rec {
          profiles = digga.lib.importers.rakeLeaves ./users/profiles;
          suites = with profiles; rec {
            base = [ direnv git ];
          };
        };
      };

      devshell.externalModules = { pkgs, ... }: {
        packages = [ pkgs.agenix ];
      };

      homeConfigurations = digga.lib.mkHomeConfigurations self.nixosConfigurations;

      deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };

      defaultTemplate = self.templates.flk;
      templates.flk.path = ./.;
      templates.flk.description = "flk template";

    }
  ;
}
