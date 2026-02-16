{
  description = "MultiHost NixFlake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }:
  let
    lib = nixpkgs.lib;

    # Recursively collect all .nix files in a directory
    collectNixFiles = dir:
      let
        entries = builtins.readDir dir;
        names   = builtins.attrNames entries;
      in
        lib.flatten (map (name:
          let path = dir + "/${name}";
          in
          if entries.${name} == "regular" && lib.hasSuffix ".nix" name then
            [ path ]
          else if entries.${name} == "directory" then
            collectNixFiles path
          else
            [ ]
        ) names);

    # All shared modules (recursive)
    sharedModules = collectNixFiles ./modules;

    # All host directories inside ./hosts
    hostDirs =
      lib.filterAttrs (_: type: type == "directory")
        (builtins.readDir ./hosts);
    username = "virusnest"

    mkHost = hostName:
      let
        system =
          if builtins.pathExists ./hosts/${hostName}/system.nix then
            import ./hosts/${hostName}/system.nix
          else
            "x86_64-linux"; # default
      in
      lib.nixosSystem {
        inherit system;
        modules =
          sharedModules
          ++ [
            ./hosts/${hostName}/configuration.nix
            home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.${username} =
                import ./home;
            }

          ];
      };

  in
  {
    nixosConfigurations =
      lib.mapAttrs' (name: _: lib.nameValuePair name (mkHost name)) hostDirs;
  };
}
