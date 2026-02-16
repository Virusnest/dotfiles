{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

outputs = { self, nixpkgs }:
let
  system = "x86_64-linux";

  mkModuleList = dir:
    map (name: dir + "/${name}")
    (builtins.filter
      (name: builtins.match ".*\\.nix" name != null)
      (builtins.attrNames (builtins.readDir dir)));
in
{
  nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
    inherit system;

    modules =
      [ ./hosts/laptop/configuration.nix ]
      ++ mkModuleList ./modules;
  };
};
}
