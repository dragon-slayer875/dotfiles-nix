{
  config,
  pkgs,
  pkgsUnstable,
  inputs,
  ...
}:
{
  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
  };

  home.packages =
    with pkgs;
    [
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

      inputs.antigravity-nix.packages.${pkgs.system}.default
      inputs.antigravity-nix.packages.${pkgs.system}.google-antigravity-ide
      inputs.antigravity-nix.packages.${pkgs.system}.google-antigravity-cli

      opencode
      codex
      vscode
    ]
    ++ [ pkgsUnstable.pmbootstrap ];
}
