{ pkgs, ... }:

{
  home.packages = [
    pkgs.pavucontrol
    pkgs.unzip
    pkgs.hyprpaper
    pkgs.swaynotificationcenter
    pkgs.nodejs_22
    pkgs.mako
    pkgs.vesktop
    pkgs.caprine
    pkgs.chromium
    pkgs.glib
    pkgs.gnome.nautilus
    pkgs.tmux
    pkgs.gh
    pkgs.git-credential-manager
    pkgs.p7zip
    pkgs.prismlauncher
    pkgs.rofi-wayland
    pkgs.eclipses.eclipse-sdk
  ];
}

