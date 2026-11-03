{pkgs, ...}: {

  # Work Wireguard
  networking.wg-quick.interfaces.work = {
    configFile = "/home/kaisel/Work/WireGuard.conf";
    autostart = false;
  };
}
