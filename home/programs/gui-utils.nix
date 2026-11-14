{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obs-studio
    qbittorrent
    surge-downloader
    signal-desktop
    signalbackup-tools
    xournalpp
    rnote
    obsidian
    (
      let
        pname = "paper-desktop";
        version = "0.5.18";
        src = pkgs.fetchurl {
          url = "https://download.paper.design/linux/appImage/x64";
          hash = "sha256-TxJ8+a8bb2XOGv7YzDoPcQ5RZ794nzbAFvRCr5aECrk=";
        };
        appimageContents = pkgs.appimageTools.extract {
          inherit pname version src;
        };
      in
      pkgs.appimageTools.wrapType2 {
        inherit pname version src;
        pkgs = pkgs;
        extraInstallCommands = "
             install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
          substituteInPlace $out/share/applications/${pname}.desktop --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${pname} --no-sandbox %U'
             cp -r ${appimageContents}/usr/share/icons $out/share
          		";
      }
    )
  ];
}
