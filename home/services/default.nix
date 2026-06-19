{ username, ... }:
{
  services = {
    syncthing = {
      enable = true;
      settings = {
        devices = {
          "main-phone" = {
            id = "6IVRSMT-VNGQE7C-XK7L6DW-SFLWYNS-7CNX7BS-ERG2KON-3RYRSK4-7GYDQQ3";
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
        };
      };
    };

    udiskie.enable = true;
  };
}
