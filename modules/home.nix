{ lib, config, pkgs, hyprland, fuzzel-pass, ... }:{
  

  home.username = "kaisel";
  home.homeDirectory = "/home/kaisel";
  home.stateVersion = "25.11";
  programs.bash = {
	enable = true;
	shellAliases = {
		btw = " test ";
		#orcaslicer 	-> orca     (launchoptions)
		#lycheeslicer 	-> lychee   (launchoptions)
		#intellij	-> intelliJ (launchoptions)
		#jupyter	-> jupyter  (launchoptions)
	};

	profileExtra = ''
		if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
			exec Hyprland
		fi
	'';
  };

  #xsession.enable = true;
  #xsession.windowManager.command = "...";

  home.file.".config/hypr".source = ../.config/hypr;		# Doesn't use the hyprlock file
  home.file.".config/waybar".source = ../.config/waybar;

  #needs proper "ricing"
  home.file.".config/foot".source = ../.config/foot;

  #needs to be properly "purged" (I don't use fuzzel)
  home.file.".config/fuzzel".source = ../.config/fuzzel;

  #needs "purging" (I only need one "riced" terminal)
  home.file.".config/ghostty".source = ../.config/ghostty;

  #Do I need thsi?
  home.file.".config/fastfetch".source = ../.config/fastfetch; 

    home.packages = with pkgs; [
      font-awesome
      jetbrains-mono
      nerd-fonts.jetbrains-mono

      # Japanese fonts
      ipafont
      kochi-substitute

      kdePackages.krdc
    ];

    #home.sessionVariables = {
    #  JETBRAINS_USE_WAYLAND = "0";
    #  GDK_BACKEND = "x11";
    #  QT_QPA_PLATFORM = "xcb";
    #  _JAVA_AWT_WM_NONREPARENTING = "1";
    #};

    home.sessionVariables = {
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland;xcb";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

 }
