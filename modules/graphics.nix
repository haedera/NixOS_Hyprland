{ pkgs, hyprland, ... }: let
  hypr-pkgs = hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  
  
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Window Manager
  nix.settings = {
    # Enable Hyprland Cachix for installing via the Flake
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Hyprland settings 
  programs.hyprland = {
    enable = true;
    withUWSM = true;  # Enables UWSM integration
    xwayland.enable = true;

    package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  xdg.portal = {
    enable = true;
    config = {
      preferred = {
        default = ["hyprland" "kde"];
        "org.freedesktop.impl.portal.FileChooser" = "kde";
      };
    };
    extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
    # extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  environment.sessionVariables = {
    # Hint to Electron Apps to use Wayland
    NIXOS_OZONE_WL = "1";
    #ELECTRON_OZONE_PLATFORM_HINT=x11;

    # XDG Variables
    XDG_DESKTOP_DIR = "";
    XDG_DOWNLOAD_DIR = "$HOME/Downloads";
    XDG_TEMPLATES_DIR = "";
    XDG_PUBLICSHARE_DIR = "";
    XDG_DOCUMENTS_DIR = "";
    XDG_MUSIC_DIR = "";
    XDG_PICTURES_DIR = "$HOME/Pictures";
    XDG_VIDEOS_DIR = "";
  };
}
