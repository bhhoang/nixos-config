{ config, pkgs, inputs, ... }:

{
  # Basic user information and Home Manager settings
  home.username = "bhhoang";
  home.homeDirectory = "/home/bhhoang";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Import modules
  imports = [
    ./modules/cursor.nix
    ./modules/git.nix
    ./modules/mako.nix
    ./modules/zsh.nix
    ./modules/chromium.nix
    ./modules/packages.nix
    ./modules/session_variables.nix
  ];

  programs.home-manager.enable = true;
}

