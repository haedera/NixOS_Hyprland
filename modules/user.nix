{ lib, config, pkgs, fuzzel-pass, ... }:{

  users.users.kaisel = {
    isNormalUser = true;
    extraGroups = [
	    "wheel"
	    "networkmanager"
	    "libvirtd"
	    "docker"
	    "wireshark"
	    "vboxusers"
	    "idea"
    ];
  };

  environment.etc."nvim/init.vim".source = ./nix.vim;

  # packages
  environment.systemPackages = with pkgs;
    [
	  
	# Generell Util
	  desktop-file-utils
	  fastfetch
	  hashcat
	  zip
	  unzip
	  man-pages
	  man-pages-posix
	  tree
	 
	# Network tools
	  traceroute
	  nmap
	  #ncat
	  wireshark
	  net-tools

	# 3D-Slicer for my Resin printer
	  lycheeslicer
	  #prusa-slicer
	
	# neovim
	  neovim
	  vscode
	  jetbrains.idea
	  #jetbrains.idea-community
	  arduino
	  #arduino-ide
	  #citool
	
	# Programming
	  gcc
	  python3
	  #python3-gi
	  jdk21
	  gdb
	  cmake
	  radare2

	
	# Desktop Util
	  fuzzel
	  ghostty
	  bemoji
	  waybar
	  hyprshot
	  hyprsunset
	  hyprlock
	  hyprshutdown
	  kdePackages.qtwayland
	  kdePackages.qtsvg
	  kdePackages.dolphin

	# Wallpaper 
	  #waypaper
	  #awww
	  #mpvpaper
	  #python-imageio
	  #python-imageio-ffmpeg
	  #python-screeninfo
	  #python-platformdirs
	
	# Clipboard
	  wl-clipboard
	  cliphist
	
	# Proton Util
	  protonmail-desktop
	  proton-pass
	  protonvpn-gui

	# Browser
	  brave
	  firefox

	# Communication Apps
	  teams-for-linux
	  discord
	  signal-desktop
  	  kdePackages.kdenlive

	# Anki
	  anki

	# Audio
	  pulseaudio            # for pactl, pacmd, etc.
 	  pipewire              # core PipeWire tools
 	  wireplumber           # PipeWire session manager
 	  pavucontrol           # GUI volume control
	  blueman
	  easyeffects

	# Minecraft
          prismlauncher

        # Flatpak (only for Hytale)
          flatpak
        ];
}

