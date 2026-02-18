{
  description = "MultiHost NixFlake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };


  outputs = { self, nixpkgs, nixpkgs-master, home-manager,  ... }:

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
    username = "virusnest";

mkHost = hostName:
      let
        system =
          if builtins.pathExists ./hosts/${hostName}/system.nix
          then import ./hosts/${hostName}/system.nix
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
            # --- THE FIX: Overlay dms-shell globally ---
            ({ ... }: {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = [
                (final: prev: {
                  dms-shell = pkgs-master.dms-shell;
                })
              ];
            })

            ./hosts/${hostName}/configuration.nix
        
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup"; 
              home-manager.extraSpecialArgs = { inherit pkgs-master; };
              home-manager.users.${username} = import ./home;
            }
          ];
      };

  in
  {
    nixosConfigurations =
      lib.mapAttrs' (name: _: lib.nameValuePair name (mkHost name)) hostDirs;
  };
}
