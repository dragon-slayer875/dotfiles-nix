{ ... }:
{
  services = {
    syncthing = {
      enable = true;
    };

    mpris-proxy.enable = true;

    udiskie.enable = true;
  };
}
