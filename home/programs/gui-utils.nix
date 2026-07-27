{ pkgs, ... }:
{
  home.packages = with pkgs; [
    baobab
    gnome-calculator
    obs-studio
    qbittorrent
    xournalpp
    rnote
  ];
}
