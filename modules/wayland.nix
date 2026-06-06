{ pkgs, inputs, ... }:
{

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true; # recommended for most users
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin # Requires an Archive manager like file-roller, ark, etc
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    kitty
    wl-clipboard
    flameshot
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    libnotify
    sddm-chili-theme
    loupe
    totem
    # poppler
    icoextract
    file-roller
  ];

  environment.sessionVariables = {
    TERMINAL = "kitty";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };

  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true;

    dbus.enable = true;
  };

  programs.dconf.enable = true;
}
