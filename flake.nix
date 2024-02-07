{
    description = "camw HPCCF Home Manager Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {nixpkgs, home-manager, ...} @ inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
        # For `nix run .` later
        defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        homeConfigurations = {
            "camw" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./home-hpccf.nix ];
                extraSpecialArgs = inputs // {
                    isNixOs = false;
                };
            };
        };
    };
}
