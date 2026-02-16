{
  description = "virusnest's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";

    mkModuleList = dir:
  let
    contents = builtins.readDir dir;
    list = nixpkgs.lib.mapAttrsToList (name: type:
      let path = dir + "/${name}"; in
      if type == "directory" 
      then mkModuleList path             # Dive into subfolders
      else if (nixpkgs.lib.hasSuffix ".nix" name) 
      then [ path ]                      # Found a file!
      else []                            # Ignore everything else
    ) contents;
  in
  builtins.concatLists list;
  in
  {
    nixosConfigurations.nixtop = nixpkgs.lib.nixosSystem {
      inherit system;

      modules =
        [ ./hosts/nixtop/configuration.nix
          ./hosts/common.nix
        ]
        ++ mkModuleList ./modules;
    };

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit system;

      modules =
        [ ./hosts/desktop/configuration.nix
          ./hosts/common.nix
        ]
        ++ mkModuleList ./modules;
    };
  };
}
