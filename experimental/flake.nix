{
    description = "camw HPCCF Home Manager Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/staging-next";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {nixpkgs, home-manager, ...} @ inputs: 
    let
        system = "x86_64-linux";
        #let pkgs = (nixpkgs.legacyPackages.${system}.extend overlay1)
        pkgs = nixpkgs.legacyPackages.${system};
        #pkgs = import nixpkgs { overlays = [ ./hpccf/overlays/nix.nix ]; };
    in {
        # For `nix run .` later
        defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        homeConfigurations = {
            "camw" = home-manager.lib.homeManagerConfiguration {
                pkgs = (pkgs.extend ( 
                        self: super: {
                            nix = super.nix.overrideAttrs (old: { 
                                doCheck = false; 
                                doInstallCheck = false; 
                            });
                        }
                        ));
                modules = [ ./home-hpccf.nix ];
                extraSpecialArgs = inputs // {
                    isNixOs = false;
                };
            };
        };
    };
}
