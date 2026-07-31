{ username, ... }:
{
  services = {
    syncthing = {
      enable = true;
      settings = {
        devices = {
          "main-phone" = {
            id = "6PVZKOR-GFVSSEO-O3M5K6Z-D7BDXCZ-GIA4QEI-DVK3MGJ-B5VDD2Y-HYSNSA4";
          };
        };
        folders = {
          "KeePass" = {
            path = "/home/${username}/Documents/KeePass";
            devices = [
              "main-phone"
            ];
            versioning = {
              type = "simple";
              params.keep = "5";
              params.cleanoutDays = "7";
            };
          };

          "Mihon" = {
            path = "/home/${username}/Documents/Mihon";
            devices = [
              "main-phone"
            ];
            versioning = {
              type = "simple";
              params.keep = "5";
              params.cleanoutDays = "7";
            };
          };

          "Notes" = {
            path = "/home/${username}/Documents/Notes";
            devices = [
              "main-phone"
            ];
            versioning = {
              type = "simple";
              params.keep = "5";
              params.cleanoutDays = "7";
            };
          };
        };
      };
    };

    udiskie.enable = true;
  };
}
