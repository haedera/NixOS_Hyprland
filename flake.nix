{
  description = "Hyprland on NixOS";

  inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    	hyprland = {
        	url = "github:hyprwm/Hyprland";
        	inputs.nixpkgs.follows = "nixpkgs";
        };
	fuzzel-pass = {
      		url = "github:d-hain/fuzzel-pass";
      		inputs.nixpkgs.follows = "nixpkgs";
    	};
	home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	};
  };
	
  outputs = { self, nixpkgs, home-manager, hyprland, fuzzel-pass, ...}: let
	system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
  in {
	nixosConfigurations = {
	
		tom-pc = nixpkgs.lib.nixosSystem {
        		inherit system;
        		specialArgs = {
        			  inherit hyprland fuzzel-pass;
        		};

        		modules = [
      				./hosts/pc/configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.kaisel = import ./modules/home.nix;
						backupFileExtension = "backup";
					};
				}
        		];
      		};

      		tom-laptop = nixpkgs.lib.nixosSystem {
        		inherit system;
       			specialArgs = {
         			inherit hyprland fuzzel-pass;
        		};

        		modules = [
          			./hosts/laptop/configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.kaisel = import ./modules/home.nix;
						backupFileExtension = "backup";
					};
				}
        		];
      		};
	};
  };
}
