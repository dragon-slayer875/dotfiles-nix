{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obs-studio
    qbittorrent
    xournalpp
    rnote
  ];
}
