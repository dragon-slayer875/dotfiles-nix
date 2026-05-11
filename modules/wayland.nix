{ pkgs, ... }:
{
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true; # recommended for most users
    };
  };

  environment.systemPackages = with pkgs; [
    kitty
    wl-clipboard
  ];

  environment.sessionVariables = {
    TERMINAL = "kitty";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };
}
