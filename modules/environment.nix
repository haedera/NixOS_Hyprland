{ lib, pkgs, ... }:
{
  # networkmanager
  networking.networkmanager.enable = true;
  #services.openssh.enable = false; --> in services.nix

  #firewall
  networking.firewall = {		# previous : networking.nftables.firewall = {
    enable = true;
    allowPing = false;
    allowedTCPPorts = [ ];
    logRefusedConnections = true;
  };
  
  # Hyprlock
  security.pam.services.hyprlock = {};

  # time zone
  time.timeZone = "Europe/Vienna";

  # Keyboard properties
  i18n.defaultLocale = "en_US.UTF-8";
  console = lib.mkDefault {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    tree
    wget
    waybar
    kitty
    ghostty
    foot
    hyprpaper
    zip
    unzip
    vim
    git
  ];
  
}
