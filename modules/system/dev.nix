# modules/system/utilities.nix
{ config, pkgs, ... }:

{
  
  # Add packages to the system environment
  environment.systemPackages = with pkgs; [
    # Basic utilities
    python315
    gcc
    openjdk25
    clang
    gnumake
    cmake
    meson
    dotnet-sdk_10
    dotnet-sdk_9
    dotnet-sdk_8
    direnv
    nix-direnv
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;


}
