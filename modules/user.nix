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
	  #john
	  zip
	  unzip
	  man-pages
	  man-pages-posix
	  tree

	# Resource - Monitoring	# Possibly needed once i implement a resource monitoring app (for waybar?)
	  #lm-sensors
	  #psutil
	  #nvidia-smi
	  #btop
	 
	# Network tools
	  #mullvad-vpn		# Needs an ".enable = true" to work
	  traceroute
	  nmap
	  #ncat
	  wireshark
	  net-tools


	# 3D-Slicer for my Resin printer
	  lycheeslicer		# requires a wrapper and environment variables to launch (Unable to login due to browser needing to launch it after Verifying)
	  #prusa-slicer		# doesn't support my 3D Printer
	
	# IDEs
	  neovim
	  vscode
	  jetbrains.idea
	  #jetbrains.idea-community
	  arduino
	  #arduino-ide		# unupported/wrong version (won't start/crashes immediatly)
	  #citool
	
	# Programming
	  gcc
	  #python3-gi
	  #pwntools
	  python3
	  #python3-gi		# throws an error while compiling
	  #(pkgs.python3.withPackages (ps: with ps; [	# failed attempt at adding extensions without pip
  	  #   #ipykernel
  	  #   numpy
 	  #   pandas
 	  #   pwntools
	  #   jupyter-all
  	  #]))
	  pwntools	# Python3 pwntools

	  jdk21
	  cmake
	  jupyter-all

	# Programm-Monitoring
	  imhex
	  radare2
	  jupyter-all
	  gdb


	# Text- Editor
	  texstudio
    	  texliveFull
	  libreoffice

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

	# Wallpaper 	# Future expansion for Hyprland ricing (needs a proper tutorial)	--> also need to do neovim ricing
	  #waypaper
	  #awww
	  #mpvpaper
	  #wallutils
	  #python3-gobject
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
	  proton-vpn	# outdated: protonvpn-gui

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

	# Launchers (mostly used for games)
          prismlauncher
          flatpak		# for Hytale
	  #nexusmods-app
	  heroic

}

