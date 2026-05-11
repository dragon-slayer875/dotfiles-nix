{ pkgs, inputs, ... }:
{
  # import the home manager module
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # configure options
  programs.noctalia-shell = {
    enable = true;

    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        polkit-agent = {
          enabled = true;
        };
      };

      version = 2;
    };

    settings = {
      # configure noctalia here
      bar = {
        position = "left";
        showCapsule = false;
        displayMode = "auto_hide";
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
          ];
          center = [
            {
              # hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              id = "Tray";
            }
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };

      colorSchemes = {
        useWallpaperColors = true;
      };

      nightLight = {
        enabled = true;
        autoSchedule = true;
        nightTemp = "4500";
        dayTemp = "6500";
      };

      general = {
        # avatarImage = "/home/drfoobar/.face";
        radiusRatio = 0.2;
      };

      ui = {
        fontDefault = "Noto Sans";
        fontFixed = "CaskaydiaCove Nerd Font Mono";
      };

      location = {
        monthBeforeDay = true;
        name = "Ghaziabad, India";
      };
    };
    # this may also be a string or a path to a JSON file.
  };
}
