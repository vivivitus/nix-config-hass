{
  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix.url = "github:mic92/sops-nix";
    systems.url = "github:nix-systems/default-linux";
    
    home-manager = {
      # url = "github:nix-community/home-manager/release-25.05";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, systems, ... }@inputs:

  let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
    in {

    inherit lib;
    nixosModules = import ./modules;
    overlays = import ./overlays {inherit inputs;};
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});

    nixosConfigurations = {
      oskar = lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./host/oskar ];
      };
    };

    homeConfigurations = {
      "vivian@oskar" = lib.homeManagerConfiguration {
        modules = [ ./home/vivian/oskar.nix ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };
  };
}
