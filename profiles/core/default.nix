{ self, config, lib, pkgs, ... }:
let inherit (lib) fileContents;
in
{
  imports = [ ../cachix ./trusted-machines.nix ];

  boot.cleanTmpDir = true;

  nix.systemFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];

  i18n.defaultLocale = "fr_CH.UTF-8";
  time.timeZone = "Europe/Zurich";

  services.xserver.layout = "custom";
  console.useXkbConfig = true;

  environment = {

    variables = {
      CDPATH = [ "." "~" ];
      LESS = "-eRSX"; # e causes less to automatically exit when it reaches end-of-file.
      # R causes less to let color sequences through.
      # S causes less not to wrap long lines.
      # X causes less not to clear the screen.
      LESSOPEN = "|${pkgs.lesspipe}/bin/lesspipe.sh %s";
      PAGER = "less";
    };

    shellAliases =
      let ifSudo = lib.mkIf config.security.sudo.enable;
      in
      {
        # quick cd
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";

        e = "$EDITOR";

        # grep
        gi = "grep -i";

        # internet ip
        myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";

        # nix
        nrb = ifSudo "sudo nixos-rebuild";

        # fix nixos-option
        nixos-option = "nixos-option -I nixpkgs=${self}/lib/compat/nixos";

        # sudo
        se = ifSudo "sudoedit";

        # systemd
        stl = ifSudo "s systemctl";
        jtl = "journalctl";

        # default conflicts w/ shortcut
        l = null;
      };

    # simple shortcut shell scripts
    systemPackages = pkgs.lib.mapAttrsToList (name: file: pkgs.writeShellScriptBin name (builtins.readFile file)) {
      l = ./l.sh;
      o = ./o.sh;
      s = ./s.sh;
    };
  };

  fonts = {
    fonts = with pkgs; [ dejavu-nerdfont libertinus ];

    fontconfig.defaultFonts = {
      sansSerif = lib.mkBefore [ "Libertinus Sans" ];
      serif = lib.mkBefore [ "Libertinus Serif" ];
    };

    # lowercase numerals
    fontconfig.localConf = ''
      <match target="font">
        <edit name="fontfeatures" mode="append">
          <string>onum on</string>
        </edit>
      </match>
    '';
  };

  hardware.nitrokey.enable = true;

  nix = {

    useSandbox = true;

    allowedUsers = [ "nix-ssh" "@users" ];

    trustedUsers = [ "root" "@wheel" ];

    extraOptions = ''
      min-free = ${toString (5 * 1024 * 1024 * 1024)}
      max-free = ${toString (10 * 1024 * 1024 * 1024)}
      keep-outputs = true
      keep-derivations = true
      fallback = true

      builders-use-substitutes = true
      keep-outputs =  true
      keep-derivations = true
    '';

    daemonNiceLevel = 1;
    daemonIONiceLevel = 1;

  };

  # not working with a flakified system
  programs.command-not-found.enable = false;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  security.pam.enableSSHAgentAuth = true;

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 6d";
  nix.gc.dates = "03:15";
  systemd.timers.nix-gc.timerConfig.Persistent = true;

  systemd.services.nix-gc.serviceConfig = {
    # allows After dependencies to fire after the GC is done.
    Type = "oneshot";
  };
  systemd.services.nix-optimise = {
    wantedBy = [ "nix-gc.service" ];
    after = [ "nix-gc.service" ];
  };

  services.openssh = {
    enable = true;
    startWhenNeeded = true;

    # hardening
    permitRootLogin = "prohibit-password";
    challengeResponseAuthentication = false;
    passwordAuthentication = false;
  };
}
