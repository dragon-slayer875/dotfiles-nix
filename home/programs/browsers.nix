{ pkgs, inputs, ... }:
{
  imports = [ inputs.zen-browser.homeModules.default ];

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
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }
    ];
  };
}
