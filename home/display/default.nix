{ pkgs, ... }:
{
  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs; [
    nwg-look
    qt6Packages.qt6ct
    adw-gtk3
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

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
