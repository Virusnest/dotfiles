{ lib }:

let
  # Recursively collect all .nix files in a directory
  collectNixFiles = dir:
    let
      entries = builtins.readDir dir;
      names   = builtins.attrNames entries;
    in
      lib.flatten (map (name:
        let
          path = dir + "/${name}";
        in
          if entries.${name} == "regular" && lib.hasSuffix ".nix" name then
            [ path ]
          else if entries.${name} == "directory" then
            collectNixFiles path
          else
            [ ]
      ) names);

in

collectNixFiles ../modules
