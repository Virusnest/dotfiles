{ config, spicetify-nix, pkgs,pkgs-master, ... }:

let
  username = "virusnest";
    spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};

in
{
  imports = [
    spicetify-nix.homeManagerModules.default
  ];
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.defaultDynamic;
    enabledExtensions = with spicePkgs.extensions; [
      wikify
      aiBandBlocker
      history
      betterGenres
    ];
    enabledCustomApps = with spicePkgs.apps;[
      nameThatTune
    ];
  };
  

    

  xdg.userDirs = {
    enable = true;
    createDirectories = true; # Force Nix to actually make the folders
    extraConfig = {
      SCREENSHOTS = "${config.home.homeDirectory}/Pictures/Screenshots";
    };
  };
  #xdg.mimeApps = {
    #enable = true;
  #};
  # Enable Home Manager features
  programs.home-manager.enable = true;
  wayland.windowManager.hyprland.systemd.enable = false;
  wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
  # Enable Dank Material Shell for the user

  # Home info
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";
  services.udiskie.enable = true;
  services.kdeconnect.enable = true;
  services.network-manager-applet.enable = true;

  # Packages for this user
  home.packages = with pkgs; [
    firefox
    (discord.override {
      withOpenASAR = true; # can do this here too
      withVencord = true;
    })
   # spotify
    mpv
    aseprite
    vlc
    blender
    gimp
    vscode
    obsidian
    prismlauncher
    krita
    steam
    lutris
    vintagestory
    jetbrains.rider
    jetbrains.pycharm
    jetbrains.idea 
    inkscape
    vencord
    osu-lazer
  ];
  #home-manager.users.virusnest.home.services.kdeconnect.enable = true;


  
        


}
