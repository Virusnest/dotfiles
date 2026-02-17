{ config, pkgs, ... }:

let
  username = "virusnest";
in
{
  # Enable Home Manager features
  programs.home-manager.enable = true;
wayland.windowManager.hyprland.systemd.enable = false;
  # Enable Dank Material Shell for the user

  # Home info
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  # Packages for this user
  home.packages = with pkgs; [
    firefox
    discord
    spotify
    vlc
    vscode
    obsidian
    prismlauncher
    krita
    easyeffects
    steam
    dms-shell
    vintagestory
  ];
}
