# modules/system/utilities.nix
{ config, pkgs, ... }:

{
  # Add packages to the system environment
  environment.systemPackages = with pkgs; [
    # Basic utilities
    libinput
    libimobiledevice
    appimage-run
    libGL
    glfw
    wayland
  ];
  programs.appimage = {
  enable = true;
  binfmt = true;
};

}
