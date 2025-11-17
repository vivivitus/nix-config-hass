{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    sops-nix.url = "github:mic92/sops-nix";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
    in
    {
    inherit lib;

    nixosModules = import ./modules;
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      oskar = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./host/oskar
        ];
      };
    };

    homeConfigurations = {
      "vivian@oskar" = lib.homeManagerConfiguration {
        modules = [ ./home/vivian/oskar.nix ];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };
  };
}
