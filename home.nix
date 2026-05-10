{
  config,
  pkgs,
  inputs,
  username,
  ...
}:

{
  imports = [ inputs.zen-browser.homeModules.default ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    # encode the file content in nix configuration file directly
    # home.file.".xxx".text = ''
    #     xxx
    # '';

    # Import the scripts directory into the Nix store,
    # and recursively generate symbolic links in the Home directory pointing to the files in the store.
    # home.file.".config/i3/scripts" = {
    #   source = ./scripts;
    #   recursive = true;   # link recursively
    #   executable = true;  # make all files executable
    # };
    file = {
      ".icons/default" = {
        source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
      };
      ".config/nvim" = {
        source = ./nvim;
      };
      ".config/kitty" = {
        source = ./kitty;
      };
      ".gitconfig" = {
        source = ./git/.gitconfig;
      };
      ".zsh/.zshrc.manual" = {
        source = ./zsh/.zshrc;
      };
    };

    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      kitty
      neofetch
      gcc
      cargo
      rustc

      # wayland clipboard
      xclip
      wl-clipboard
      cliphist

      # archives
      zip
      xz
      unzip
      p7zip

      # utils
      ripgrep
      eza
      fzf
      fd
      zoxide
      bat

      obs-studio
      libreoffice-qt
      hunspell
      lazygit
      heroic
      stremio-linux-shell

      # networking tools
      mtr # A network diagnostic tool
      iperf3
      dnsutils # `dig` + `nslookup`
      ldns # replacement of `dig`, it provide the command `drill`
      socat # replacement of openbsd-netcat
      nmap # A utility for network discovery and security auditing
      ipcalc # it is a calculator for the IPv4/v6 addresses

      # misc
      file
      gnused
      gnutar
      gawk
      zstd
      gnupg

      # nix related
      #
      # it provides the command `nom` works just like `nix`
      # with more details log output
      nix-output-monitor

      btop # replacement of htop/nmon
      iotop # io monitoring
      iftop # network monitoring

      # system call monitoring
      strace # system call monitoring
      ltrace # library call monitoring
      lsof # list open files

      # system tools
      sysstat
      lm_sensors # for `sensors` command
      ethtool
      pciutils # lspci
      usbutils # lsusb
    ];

    # This value determines the home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update home Manager without changing this value. See
    # the home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "25.11";
  };

  xdg.autostart.enable = true;

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Rudraksh Tyagi";
        email = "rudraksh875@gmail.com";
      };
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    history.size = 20000;
    history.path = "$HOME/.histfile";
    initContent = ''
      source ~/.zsh/.zshrc.manual
    '';
  };

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    policies =
      let
        mkExtensionSettings = builtins.mapAttrs (
          _: pluginId: {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
            installation_mode = "force_installed";
          }
        );
      in
      {
        ExtensionSettings = mkExtensionSettings {
          "uBlock0@raymondhill.net" = "ublock-origin";
          "addon@darkreader.org" = "darkreader";
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = "vimium-ff";
        };
        DisableAppUpdate = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        EnableTrackingProtection = {
          Value = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };

    profiles.default = {
      settings = {
        "zen.workspaces.continue-where-left-off" = true;
        "zen.view.compact.hide-tabbar" = true;
        "zen.urlbar.behavior" = "float";
      };

      # mods = [
      # ];

      search = {
        force = true;
        default = "ddg";
      };
    };
  };

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      "eimadpbcbfnmbkopoojfekhnkhdbieeh"
      "dbepggeogbaibhgnhhndojpepiihcmeb"
    ];
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks."*" = {
      forwardAgent = false;
      addKeysToAgent = "no";
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };

    extraConfig = "
  Host github.com
  	HostName github.com
	IdentityFile ~/.ssh/gh_access
	IdentitiesOnly yes
	User git
	";
  };

  programs.keepassxc = {
    enable = true;
    autostart = true;
  };

  services = {
    mpris-proxy.enable = true;

    syncthing = {
      enable = true;
    };

    udiskie.enable = true;
  };

  programs.home-manager.enable = true;

}
