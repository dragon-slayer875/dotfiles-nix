{ username, pkgs, ... }:
{
  users.users.${username}.extraGroups = [ "docker" ];

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
    };
  };

}
