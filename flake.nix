{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./hosts/laptop/configuration.nix
      ];
    };
  };
}
