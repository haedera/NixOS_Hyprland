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
	  gcc
	  python3
	  gdb
	  cmake
	  radare2
	  fastfetch
	  #ncat
	  nmap
	  traceroute
	  hashcat
	  zip
	  unzip
	  man-pages
	  man-pages-posix	
	  net-tools

	# Resin Printer Slicer
	  lychee
	  #prusa-slicer
	
	# neovim
	  neovim
	  vscode
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
	  pavucontrol
	  blueman
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

	# 'Normal' programs
	  brave
	  firefox
	  teams-for-linux
	  discord
	  signal-desktop
	  wireshark
  	  kdePackages.kdenlive
	  anki

	  # Minecraft
          prismlauncher
          # Flatpak (only for Hytale)
          flatpak
        ];
#        ++ config.user.packages;
}

