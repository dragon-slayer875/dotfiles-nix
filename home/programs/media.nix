{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obs-studio
    heroic
    stremio-linux-shell
  ];
}
