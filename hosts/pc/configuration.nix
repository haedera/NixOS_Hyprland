{ config, lib, pkgs, hyprland, fuzzel-pass, ... }: let
  username = "kaisel";
in {
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" "wireshark" ];
  };

  environment.systemPackages = with pkgs; [
    tree
    gcc
    neovim
    fastfetch
    wl-clipboard
  ];

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/programs.nix
      ../../modules/services.nix
      ../../modules/environment.nix
      ../../modules/graphics.nix
      ../../modules/hardware_settings.nix
      ../../modules/hyprsunset.nix
      ../../modules/jai.nix
      ../../modules/japanese.nix
      ../../modules/nix_settings.nix
      ../../modules/wireshark.nix
      ../../modules/user.nix
      ../../modules/nix.vim
      # ../../modules/home.nix
      ../../git_config/gitconfig.nix
      # ../../.ssh
    ];

  # Network stuff
  networking.hostName = "tom-pc";
  security.rtkit.enable = true;

  # Intel CPU Microcode
  hardware.cpu.intel.updateMicrocode = true;

  # NVIDIA RTX 4090
  services.xserver.videoDrivers = [ "nvidia" ];

  boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.nvidia = {
    modesetting.enable = true;   # wichtig für Wayland
    nvidiaSettings = true;

    # Für 4090 empfehlenswert (beste Kompatibilität):
    open = false;

    # Stabiler Treiber aus deinem aktuellen Kernelpaket
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Optional, aber meist sinnvoll:
    persistence = true;  # hält das NVIDIA-Modul "warm"
    powerManagement.enable = true;
  };

  # OpenGL/Vulkan + 32-bit (Steam)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Wayland/Hyprland: optionaler Fix, falls Cursor-Flicker o.ä.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
  
  # Sound
  services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
     wireplumber.enable = true;
  };   
  
  # Autologin
  services.getty.autologinUser = "kaisel";

  # Allow Unfree Packages explicitly
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "steam-original"
      "steam-run"
      "discord"
      # NVIDIA
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
    ];  
    

  # programs.firefox.enable = true;

  programs.zsh.shellAliases.enxc = "cd ~/NixOS/ && nvim ./hosts/laptop/configuration.nix";

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

