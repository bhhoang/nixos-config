{ pkgs, ... }:

{
  home.pointerCursor = with pkgs; {
    gtk.enable = true;
    x11.enable = true;
    x11.defaultCursor = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };
}

