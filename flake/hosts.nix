{ nixpkgs, nixpkgs-master, home-manager, sharedModules, username }:

hostName:

let
  lib = nixpkgs.lib;

  system =
    if builtins.pathExists ../hosts/${hostName}/system.nix
    then import ../hosts/${hostName}/system.nix
    else "x86_64-linux";

  pkgs-master = import nixpkgs-master {
    inherit system;
    config.allowUnfree = true;
  };
in

lib.nixosSystem {
  inherit system;

  specialArgs = { inherit pkgs-master; };

  modules =
    sharedModules
    ++ [
      ../hosts/${hostName}

      home-manager.nixosModules.home-manager
    ];
}