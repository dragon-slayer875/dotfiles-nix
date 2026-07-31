{ pkgs, ... }: {

  home.packages = with pkgs; [
    lazygit
    gh

    gcc
    cargo
    rustc
    nil
    statix
    nixfmt

    xclip
    cliphist
    android-tools
  ];
}
