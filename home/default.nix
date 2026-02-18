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
  ];

  
  gtk.iconTheme.name = "adwaita-icon-theme";
  gtk.iconTheme.package = pkgs.adwaita-icon-theme;
  gtk.enable=true;
  xdg.configFile."gtk-3.0/settings.ini".force = true;
  xdg.configFile."gtk-4.0/settings.ini".force = true;

services.easyeffects.enable = true;
}
