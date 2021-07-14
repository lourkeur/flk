{ lib, ... }:

{
  allowUnfreePredicate = pkg:
    let pname = lib.getName pkg;
    in
    builtins.elem pname [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "Oracle_VM_VirtualBox_Extension_Pack"
      "android-studio-stable"
      "sqldeveloper"
      "oraclejdk"
    ];

  doCheckByDefault = false;

  firefox = {
    enableBrowserpass = true;
    enableGnomeExtensions = true;
  };
}
