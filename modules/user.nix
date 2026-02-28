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

