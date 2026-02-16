{ config, pkgs, ... }:
{
 home.username = "virusnest";
 home.homeDirectory = "/home/virusnest";
 home.stateVersion = "23.11";

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
 ];

programs.home-manager.enable = true;

}
