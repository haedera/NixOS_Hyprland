{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/programs.nix
      ./modules/services.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network stuff
  networking.hostName = "tom-pc";
  networking.networkmanager.enable = true;
  # networking.firewall.checkReversePath = false;  

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Sound
  services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
     wireplumber.enable = true;
  };   
  
  # services.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Autologin
  services.getty.autologinUser = "tom";

  # Hyprland
  programs.hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland.override {legacyRenderer = false; };
      xwayland.enable = true;
      withUWSM = true;
  };
  
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Enable OpenGL and graphics
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load NVIDIA driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable modesetting (required for NVIDIA on Wayland)
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true; # Only for Turing+ GPUs (RTX 20-series and newer)
    open = true; # Use open-source NVIDIA kernel module (recommended for newer GPUs)
    nvidiaSettings = true;
    # Use beta driver for best compatibility with newer GPUs
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };  

  # Set keyboardlayout to the german one
  services.xserver.xkb = {
    layout = "de";
    variant = "";
    #caps:swapescape;
  };

  # font package
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono

    # Japanese font
    ipafont
    kochi-substitute
  ];

  # Allow Unfree Packages explicitly
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      
      "steam"
      "steam-unwrapped"
      "steam-original"
      "steam-run"
      
      "discord"
      "google-chrome"
      "synology-drive-client"
      "osu-lazer-bin"
    ];  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tom = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    wget
    foot
    kitty
    waybar
    git
    hyprpaper
  ];	

  # Enable certain experimental features  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.11"; # No changes "25.11"

}
