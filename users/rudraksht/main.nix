{ pkgs, config, ... }:
{
  imports = [
    ../../home/core.nix

    ../../home/programs
    ../../home/services
    ../../home/display
    ../../home/hyprland
    ../../home/noctalia
  ];

  home.file = {
    ".icons/default" = {
      source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
    };
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles-nix/dotfiles/nvim/.config/nvim";
    };
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles-nix/dotfiles/kitty/.config/kitty";
    };
    ".gitconfig" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles-nix/dotfiles/git/.gitconfig";
    };
    ".zsh/.zshrc.manual" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles-nix/dotfiles/zsh/.zshrc";
    };
  };

  home.packages = with pkgs; [
    neofetch
    lazygit
    gh

    gcc
    cargo
    rustc

    xclip
    cliphist
  ];

  # home.shellAliases = {
  #   k = "kubectl";
  # };

  # add environment variables
  home.sessionVariables = {
    # set default applications
    BROWSER = "zen-beta";
  };

  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "Rudraksh Tyagi";
          email = "rudraksh875@gmail.com";
        };
      };
    };

    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      extraConfig = "mouse on";
    };

    ssh = {
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

	Host myHome-server
	  HostName 192.168.1.7
	  IdentityFile ~/.ssh/server_access
	  User rudr875
	  Port 875

	Host myHome-server-vlan
	  HostName 10.0.0.1
	  IdentityFile ~/.ssh/server_access
	  User rudr875
	  Port 875
	";
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      history.size = 20000;
      history.path = "$HOME/.histfile";
      initContent = ''
        source ~/.zsh/.zshrc.manual
      '';
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
