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
	  net-tools

	# Resin Printer Slicer
	  lycheeslicer
	  #prusa-slicer
	
	# neovim
	  neovim
	  vscode
	  jetbrains.idea
	  #jetbrains.idea-community
	  arduino-ide
	  #citool
	
	# Programming
	  gcc
	  python3
	  jdk21
	  gdb
	  cmake
	  radare2

	# Nettools
	  nmap
	  wireshark
	  traceroute
	  #ncat
	
	# Desktop Util
	  fuzzel
	  ghostty
	  bemoji
	  waybar
	  hyprshot
	  hyprsunset
	  hyprlock
	  hyprshutdown
	  pavucontrol
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
	  firefox

	# Communication Apps
	  teams-for-linux
	  discord
	  signal-desktop
	  kdePackages.kdenlive

	# Generall Apps
	  anki

	# Audio
	  pulseaudio            # for pactl, pacmd, etc.
 	  pipewire              # core PipeWire tools
 	  wireplumber           # PipeWire session manager
 	  pavucontrol           # GUI volume control
	  blueman

	# Minecraft
          prismlauncher
        
	# Flatpak (only for Hytale)
          flatpak
        ];
}

