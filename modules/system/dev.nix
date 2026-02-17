# modules/system/utilities.nix
{ config, pkgs, ... }:

{
  # Add packages to the system environment
  environment.systemPackages = with pkgs; [
    # Basic utilities
    python315
    dotnet-sdk_10
    dotnet-sdk_9
    dotnet-sdk_8
];
}
