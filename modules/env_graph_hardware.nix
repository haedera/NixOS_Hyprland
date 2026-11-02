{ lib, pkgs, hyprland, ... }: let
  hypr-pkgs = hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  

  #####################################################
  ##---------------  System-Settings  ---------------##
  #####################################################

  #System-wide packages
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

  # time zone
  time.timeZone = "Europe/Vienna";

  
  #####################################################
  ##---------------  Display-Manager  ---------------##
  #####################################################

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;


  #####################################################
  ##---------------  Window--Manager  ---------------##
  #####################################################

  # Window Manager
  nix.settings = {
    # Enable Hyprland Cachix for installing via the Flake
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };


  #####################################################
  ##--------------  Hyprland Settings  --------------##
  #####################################################

  # Hyprland settings 
  programs.hyprland = {
    enable = true;
    withUWSM = false;  # Disable UWSM integration
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

  # Hyprlock
  security.pam.services.hyprlock = {};



  #####################################################
  ##------------  Environment Settings  -------------##
  #####################################################

  environment.sessionVariables = {
    # Hint to Electron Apps to use Wayland
    NIXOS_OZONE_WL = "1";
    #ELECTRON_OZONE_PLATFORM_HINT=x11;

    # XDG Variables
    XDG_DESKTOP_DIR = "";
    XDG_DOWNLOAD_DIR = "$HOME/Downloads";
    XDG_TEMPLATES_DIR = "";
    XDG_PUBLICSHARE_DIR = "";
    XDG_DOCUMENTS_DIR = "$HOME/Documents";
    XDG_MUSIC_DIR = "";
    XDG_PICTURES_DIR = "$HOME/Pictures";
    XDG_VIDEOS_DIR = "";
  };


  #####################################################
  ##---------------  Network-manager  ---------------##
  #####################################################

  networking.networkmanager.enable = true;
  #services.openssh.enable = false; --> in services.nix


  #####################################################
  ##--------------  Firewall Settings  --------------##
  #####################################################

  networking.firewall = {		
    enable = true;
    allowPing = false;
    allowedTCPPorts = [ ];
    logRefusedConnections = true;
  };


  #####################################################
  ##------------------  Bluetooth  ------------------##
  #####################################################

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; 			#optional
  };

  services.blueman.enable = true; 		#GUI/Applet/Manager (optional)


  #####################################################
  ##---------------  Boot-Loader/EFI  ---------------##
  #####################################################

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 15;
    };
    efi.canTouchEfiVariables = true;
  };


  #####################################################
  ##--------------------  Input  --------------------##
  #####################################################

  #Mouse-wheel-sens	
  services.libinput.enable = true;
  environment.etc = {
    "libinput/local-overrides.quirks".text = ''
      [DisableThatShitHighResolution]
      MatchName=*
      AttrEventCode=-REL_WHEEL_HI_RES;-REL_HWHEEL_HI_RES;
    '';
  };


  #Keyboard properties
  i18n.defaultLocale = "en_US.UTF-8";
  console = lib.mkDefault {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

}



