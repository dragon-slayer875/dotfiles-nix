{ pkgs, config, ... }:
{
  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
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

  xdg.configFile = {
    "gtk-4.0/assets" = {
      source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    };

    "gtk-4.0/gtk.css" = {
      source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    };

    "gtk-4.0/gtk-dark.css" = {
      source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    };
  };
}
