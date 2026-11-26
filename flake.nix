{
  description = "me-flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      nixos_vm = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              # more details: https://nix-community.github.io/home-manager/nix-flakes/nixos.html#sec-flakes-nixos-module
              useGlobalPkgs = true;
              useUserPackages = true;
              users.dog = import ./home.nix;
              backupFileExtension = "baknix";
            };
          }
        ];
      };
    };
  };
}
