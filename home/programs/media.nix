{
  pkgs,
  username,
  ...
}:
{
  home.packages = with pkgs; [
    obs-studio
    heroic
    stremio-linux-shell
    playerctl
    nicotine-plus
    rmpc
  ];

  services = {
    playerctld.enable = true;
    mpd = {
      enable = true;
      musicDirectory = "~/Music";
      playlistDirectory = /home/${username}/Music/Playlists;
      network.listenAddress = "/home/${username}/.local/share/mpd/socket";
      # default data dir is .local/share
      # dataDir = "~/.config/mpd";
      extraConfig = ''
                		restore_paused "yes"
                		auto_update "yes"
        				save_absolute_paths_in_playlists "yes"

                		# must specify one or more outputs in order to play audio!
                		# (e.g. ALSA, PulseAudio, PipeWire), see next sections
                		audio_output {
                		  type "pipewire"
                		  name "My PipeWire Output"
                		}

                        audio_output {
                            type                    "fifo"
                            name                    "visualizer_out"
                            path                    "/tmp/mpd.fifo"
                            format                  "44100:16:2"
                        }
      '';
    };
    mpris-proxy.enable = true;
  };
}
