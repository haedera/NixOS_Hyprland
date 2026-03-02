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
	  radare2
	  fastfetch
	# ncat
	  nmap
	  traceroute
	  hashcat
	  zip
	  unzip
	  man-pages
	  man-pages-posix
	  prusa-slicer	
	  net-tools	
	
	# neovim
	  neovim
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
	# protonmail-bridge
	# protonmail-bridge-gui
	  protonmail-desktop
	  proton-pass
	  protonvpn-gui

	  # 'Normal' programs
	  brave
	  teams-for-linux
	  discord
	  flatpak
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

