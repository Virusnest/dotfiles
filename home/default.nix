{ config, pkgs,pkgs-master, ... }:

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
services.kdeconnect.enable = true;

  # Packages for this user
  home.packages = with pkgs; [
    firefox
    discord
    spotify
    mpv
    vlc
    blender
    vscode
    obsidian
    prismlauncher
    krita
    steam
    lutris
    pkgs-master.dms-shell
    vintagestory
    jetbrains.rider
    jetbrains.pycharm
    jetbrains.idea 
    xournalpp
    easyeffects
  ];
  #home-manager.users.virusnest.home.services.kdeconnect.enable = true;





}
