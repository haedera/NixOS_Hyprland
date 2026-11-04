{ config, lib, pkgs, hyprland, fuzzel-pass, ... }: let
  username = "kaisel";
  hypr-pkgs = hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel" 
      "networkmanager"
      "docker"
      "libvirtd"
      "wireshark"
      "kvm"
      "vboxusers"
      "idea"
    ];
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
      ../../modules/hyprsunset.nix
      ../../modules/jai.nix
      ../../modules/japanese.nix
      ../../modules/nix_settings.nix
      ../../modules/user.nix
      ../../git_config/gitconfig.nix
      ../../modules/hardware_environment.nix
      ../../modules/programs_services.nix
    ];

  #####################################################
  ##------------------  Networking  -----------------##
  #####################################################

  networking.hostName = "tom-laptop";
  security.rtkit.enable = true;

  
  #####################################################
  ##---------------  Hardware-CPU-iGPU  -------------##
  #####################################################

  hardware.graphics = {
    enable = true;

    extraPackages = [
    	pkgs.rocmPackages.clr.icd
    ];

    # 32bit Support (eg. Steam)
    enable32Bit = true;

    package = hypr-pkgs.mesa;
    package32 = hypr-pkgs.pkgsi686Linux.mesa;
  };

  services.xserver.videoDrivers = ["amdgpu"];
  #services.xserver.enable = true;


  #####################################################
  ##---------------------  Sound  -------------------##
  #####################################################

  services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
     wireplumber.enable = true;
  };  

  

  #####################################################
  ##---------------  Nix-Unfree-Pkgs  ---------------##
  #####################################################

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # Steam
      "steam"
      "steam-unwrapped"
      "steam-original"
      "steam-run"

      # Discord
      "discord"
      "discord-unwrapped"

      # NVIDIA
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "nvidia-kernel-modules"

      # Development
      "vscode"
      "intellij-idea"

      # 3D-printer
      "lycheeslicer"
      "orca-slicer"

      # VBox -> maybe removed for qemu in the future
      "virtualbox-extpack"
    ];  

    # temporary:
  nixpkgs.config.problems.handlers."gtk+".broken = "ignore";


  #####################################################
  ##----------------  Shell-Aliases?  ---------------##
  #####################################################

  programs.zsh.shellAliases.enxc = "cd ~/NixOS/ && nvim ./hosts/laptop/configuration.nix";


  #####################################################
  ##-------------------  KEEP-AWAY  -----------------##
  #####################################################

  system.stateVersion = "25.11"; # No changes "25.11"

}

