{ lib, config, pkgs, fuzzel-pass, ... }:{

  users.users.kaisel = {
    isNormalUser = true;
    extraGroups = [
	    "wheel"
	    "networkmanager"
	    "libvirtd"
	    "docker"
	    "wireshark"

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

	# Programming
	  python3
	  neovim
	  gcc
	  gdb
	  radare2
	  jdk21
	  jetbrains.idea
	  #citool
	
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

	# Clipboard
	  wl-clipboard
	  cliphist
	
	# Proton Util
	  protonmail-desktop
	  proton-pass
	  protonvpn-gui

	# Browser
	  brave

	# Communication Apps
	  teams-for-linux
	  discord
	  signal-desktop
  	  kdePackages.kdenlive

	# Anki
	  anki

	# Audio and Bluetooth
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

