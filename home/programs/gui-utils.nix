{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obs-studio
    qbittorrent
    surge-downloader
    xournalpp
    rnote
    obsidian
  ];
}
