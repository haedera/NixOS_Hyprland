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
#  home.file.".gitconfig".source = ./git_config/.gitconfig;


#  options.user = {
#    enable = lib.mkEnableOption "User Account";
#
#    username = lib.mkOption {
#      default = "hadera";
#      description = "Username";
#    };
#
#    packages = lib.mkOption {
#      default = [];
#      description = "Additional system specific packages";
#    };
#  };

#  config = lib.mkIf config.user.enable {
#    # Environment variables
#    environment.variables = {
#      EDITOR = "nvim";
#      TERMINAL = "ghostty";
#    };

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
