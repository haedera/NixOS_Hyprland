{ config, lib, pkgs, hyprland, fuzzel-pass, ... }: let
  username = "kaisel";
in {
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ 
	"wheel"
	"networkmanager"
	"docker"
	"libvirtd"
	"wireshark"
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
      # ../../modules/nix.vim
      # ../../modules/home.nix
      ../../git_config/gitconfig.nix
      # ../../.ssh
    ];

  # Network stuff
  networking.hostName = "tom-pc";
  security.rtkit.enable = true;


  # Intel CPU
  hardware.cpu.intel.updateMicrocode = true;
  services.thermald.enable = true;
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };


  # NVIDIA GPU
  boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.nvidia = {
    modesetting.enable = true;   # for Wayland
    nvidiaSettings = true;

    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    nvidiaPersistenced = true;
    powerManagement.enable = true;
  };
 
  services.xserver = {
    enable = true;
    enableCtrlAltBackspace = true;
    videoDrivers = [ 
	"nvidia"
	# "displaylink" --> X11
   ];
  #deviceSection = ''
  #  Option "Coolbits" "28"
  #'';
  };

   boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];


  # OpenGL/Vulkan + 32-bit (Steam)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };


  # Wayland/Hyprland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    # WLR_NO_HARDWARE_CURSORS = "1";
  };


  # Enable Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;

      # Required since the Audio Jack is in the case and therefore not recognized otherwise
      extraConfig = {
        "10-default-output" = {
          "monitor.alsa.rules" = [
          {
            matches = [
              { "node.name" = "alsa_output.pci-0000_00_1f.3.analog-stereo"; }
            ];
            actions = {
              update-props = {
                "priority.session" = 2000;
                "priority.driver" = 2000;
                };
              };
            }
          ];
        };
      };
    };
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
      "vscode"
      "idea"
      "lycheeslicer"
      "virtualbox-extpack"
    ];  
    

  programs.zsh.shellAliases.enxc = "cd ~/NixOS/ && nvim ./hosts/pc/configuration.nix";

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

