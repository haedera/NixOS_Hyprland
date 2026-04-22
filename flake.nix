{
  description = "Hyprland on NixOS";

  inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    	hyprland = {
        	url = "github:hyprwm/Hyprland";
        	inputs.nixpkgs.follows = "nixpkgs";
    	};
	home-manager = {
		url = "github:nix-community/home-manager";
		# url = "github:nix-community/home-manager/release-25.11";
		inputs.nixpkgs.follows = "nixpkgs";
	};
  };
	
  outputs = { self, nixpkgs, home-manager, hyprland, ...}: let
     #homeConfigurations."yourusername" = home-manager.lib.homeManagerConfiguration {
	system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
	# modules = [ ./home.nix ];
     #}
  in {
	nixosConfigurations = {
	
		tom-pc = nixpkgs.lib.nixosSystem {
        		inherit system;
        		specialArgs = {
        			  inherit hyprland;
        		};

        		modules = [
      				./hosts/pc/configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.kaisel = {
							imports = [
							  ./modules/home.nix
							];
						};
						backupFileExtension = "backup";
					};
				}
        		];
      		};

      		tom-laptop = nixpkgs.lib.nixosSystem {
        		inherit system;
       			specialArgs = {
         			inherit hyprland;
        		};

        		modules = [
          			./hosts/laptop/configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.kaisel = {
							imports = [
							  ./modules/home.nix
							];
						};
						backupFileExtension = "backup";
					};
				}
        		];
      		};
	};
  };
}
