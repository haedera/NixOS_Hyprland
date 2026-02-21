{ lib, pkgs, ... }:
{
  # networkmanager
  networking.networkmanager.enable = true;

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
    kitty
    waybar
    foot
    hyprpaper
    zip
    unzip
    vim
    git
  ];
  
}
