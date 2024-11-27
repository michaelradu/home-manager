{
  description = "Home Manager configuration of alex";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { nixpkgs, home-manager, nixvim, nixgl, ... }:
    let
      #system = "x86_64-linux";
      #pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs {
	system = "x86_64-linux";
	overlays = [ nixgl.overlay ];
      };
    in {
      homeConfigurations = {
        alex = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [ 
		./home-manager/home.nix
		nixvim.homeManagerModules.nixvim 
		{ nixpkgs.config.allowUnfree = true ; }
	    ];
	    
            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
          };
        };
    };
}
