{ pkgs, ... }:

# tweaks for my Gnome Desktop

let extensions = with pkgs.gnomeExtensions; [
  gtk-title-bar
  hide-activities-button
  hot-edge
  removable-drive-menu
];

in
{
  home.packages = extensions;
  dconf.settings = {
    "org/gnome/shell".enabled-extensions = map (p: p.extensionUuid or p.uuid) extensions;
    "org/gnome/shell/extensions/gtktitlebar".restrict-to-primary-screen = false;
    "org/gnome/desktop/interface".enable-hot-corners = false; # we have a hot-edge instead
  };
}
