{ pkgs, inputs, ... }:
{

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true; # recommended for most users
    };

    # noctalia-shell = {
    #   enable = true;
    #   settings = {
    #     # configure noctalia here
    #     bar = {
    #       density = "compact";
    #       position = "right";
    #       showCapsule = false;
    #       widgets = {
    #         left = [
    #           {
    #             id = "ControlCenter";
    #             useDistroLogo = true;
    #           }
    #           {
    #             id = "Network";
    #           }
    #           {
    #             id = "Bluetooth";
    #           }
    #         ];
    #         center = [
    #           {
    #             hideUnoccupied = false;
    #             id = "Workspace";
    #             labelMode = "none";
    #           }
    #         ];
    #         right = [
    #           {
    #             alwaysShowPercentage = false;
    #             id = "Battery";
    #             warningThreshold = 30;
    #           }
    #           {
    #             formatHorizontal = "HH:mm";
    #             formatVertical = "HH mm";
    #             id = "Clock";
    #             useMonospacedFont = true;
    #             usePrimaryColor = true;
    #           }
    #         ];
    #       };
    #     };
    #     colorSchemes.predefinedScheme = "Monochrome";
    #     general = {
    #       # avatarImage = "/home/drfoobar/.face";
    #       radiusRatio = 0.2;
    #     };
    #     location = {
    #       monthBeforeDay = true;
    #       name = "Ghaziabad, India";
    #     };
    #   };
    #   # this may also be a string or a path to a JSON file.
    # };
  };

  environment.systemPackages = with pkgs; [
    kitty
    wl-clipboard
    flameshot
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    libnotify
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
  };
}
