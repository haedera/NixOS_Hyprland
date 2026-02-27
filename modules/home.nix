{ lib, config, pkgs, hyprland, fuzzel-pass, ... }:{
  

  home.username = "kaisel";
  home.homeDirectory = "/home/kaisel";
  home.stateVersion = "25.11";
  programs.bash = {
	enable = true;
	shellAliases = {
		btw = " test ";
	};
	profileExtra = ''
		if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
			exec uwsm start -S hyprland-uwsm.desktop
		fi
	'';
  };

  home.file.".config/hypr".source = ../config/hypr;
  home.file.".config/waybar".source = ../config/waybar;
  home.file.".config/foot".source = ../config/foot;
  home.file.".config/fuzzel".source = ../config/fuzzel;
  home.file.".config/ghostty".source = ../config/ghostty;
  home.file.".config/fastfetch".source = ../config/fastfetch;
  
  nixosConfigurations = {
	tom-pc = nixpkgs.lib.nixosSystem {
 		home.file.".config/hypr".source = ../config/hypr && ../hosts/laptop/config/hypr
		home.file.".config/waybar".source = ../config/waybar && ../hosts/laptop/config/waybar
	};
	tom-laptop = nixpkgs.lib.nixosSystem {
		home.file.".config/hypr".source = ../config/hypr && ../hosts/laptop/config/hypr
		home.file.".config/waybar".source = ../config/waybar && ../hosts/laptop/config/waybar
	};
  };

    home.packages = with pkgs; [
      font-awesome
      jetbrains-mono
      nerd-fonts.jetbrains-mono

      # Japanese fonts
      ipafont
      kochi-substitute

      kdePackages.krdc
    ];

 }
