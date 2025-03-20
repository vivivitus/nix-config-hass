{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    home-manager = {
      #url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/release-24.11";
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

    images = {
      homeassistant = (self.nixosConfigurations.cm4.extendModules {
        modules = [
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64-new-kernel-no-zfs-installer.nix"
          {
            nixpkgs.config.allowUnsupportedSystem = true;
            nixpkgs.hostPlatform.system = "aarch64-linux";
            nixpkgs.buildPlatform.system = "x86_64-linux";
          }
        ];
      }).config.system.build.sdImage;
    };

    nixosConfigurations = {
      homeassistant = lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit inputs outputs; };
        modules = [
          nixos-hardware.nixosModules.raspberry-pi-4
          ./host/homeassistant
        ];
      };
    };

    homeConfigurations = {
      "vivian@homeassistant" = lib.homeManagerConfiguration {
        modules = [ ./home/vivian/homeassistant.nix ];
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };
  };
}
