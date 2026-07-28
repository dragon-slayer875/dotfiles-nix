{
  lib,
  config,
  ...
}:
let
  kver = config.boot.kernelPackages.kernel.version;
  nvidiaPackage = config.hardware.nvidia.package;
in

{
  imports = [
    ../../modules/system.nix
    ../../modules/wayland.nix
    ../../modules/kanata.nix
    ../../modules/virt-manager.nix
    ../../modules/docker.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  fileSystems."/mnt/drive_e" = {
    options = [
      "x-gvfs-show"
    ];
  };

  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "main-comp"; # Define your hostname.

  # Enable hardware
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    amdgpu.initrd.enable = true;
    nvidia = {
      open = lib.mkOverride 990 (nvidiaPackage ? open && nvidiaPackage ? firmware);
      modesetting.enable = true;
      prime = {
        amdgpuBusId = "PCI:6:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    bluetooth.enable = true;
    opentabletdriver.enable = true;
  };

  qt.enable = true;

  services = {
    logind = {
      settings.Login = {
        HandleLidSwitch = "ignore";
      };
    };

    displayManager.sddm = {
      enable = true;
      theme = "chili";

      # Enables experimental Wayland support
      wayland.enable = true;
    };

    # Enable the X11 windowing system.

    xserver = {
      enable = true;
      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = [
        "modesetting"
        "nvidia"
      ];

      # displayManager.lightdm = {
      #   enable = true;
      #   greeters.slick = {
      #     enable = true;
      #     cursorTheme = {
      #       name = "Bibata-Modern-Classic";
      #     };
      #   };
      # };

      # Enable the XFCE Desktop Environment.
      # desktopManager.xfce.enable = true;
    };

    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images

    printing.enable = true;
    blueman.enable = true;
    # Useful for SSDs as helps maintain performance by discarding unused blocks
    fstrim.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    flatpak.enable = true;
  };

  security.rtkit.enable = true;

  programs = {
    steam.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
