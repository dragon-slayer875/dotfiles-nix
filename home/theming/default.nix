{ pkgs, config, ... }:
{
  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs; [
    nwg-look
    qt6Packages.qt6ct
    (catppuccin-gtk.override {
      variant = "macchiato";
      accents = [
        "lavender"
        "yellow"
      ];
      # size = "standard";
      # tweaks = [
      #   "rimless"
      #   "black"
      # ];
    })
  ];

  gtk = {
    enable = true;

    # necessary to correctly theme gnome apps by removing and setting files created by nwglook from .config/gtk-4.0
    gtk4 = {
      enable = false;
    };

    # this theme is needed to use noctalia's color scheme in gtk apps
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    colorScheme = "dark";

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.file = {
    ".config/gtk-4.0/gtk.css" = {
      text = ''
        @import url("noctalia.css");
        	'';
    };
  };
}
