{ config, pkgs,pkgs-master, ... }:


{

  security.pam.services.login.fprintAuth = true;
programs.dms-shell = {
  enable = true;

  systemd.enable=true;
  
  # Core features
  enableSystemMonitoring = true;     # System monitoring widgets (dgop)
  enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
  enableAudioWavelength = true;      # Audio visualizer (cava)
  enableCalendarEvents = true;       # Calendar integration (khal)
};
services.displayManager.dms-greeter = {
  enable = true;
  compositor.name = "hyprland";  # Or "hyprland" or "sway"
  configHome = "/home/virusnest";
};
 programs.hyprland = {
  enable = true;
  xwayland.enable = true;
  package = pkgs-master.hyprland;
  withUWSM = true; # recommended for most users
 };
 environment.sessionVariables = {
  NIXOS_OZONE_WL="1";
  QT_QPA_PLATFORMTHEME="qt6ct";
  QT_QPA_PLATFORMTHEME_QT6="qt6ct";
 };     
 programs.kdeconnect.enable = true;
 networking.firewall = rec {
  allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  allowedUDPPortRanges = allowedTCPPortRanges;
  };
 programs.uwsm.enable = true;
 environment.systemPackages = with pkgs; [
  kitty
  rofi
  wayscriber
  quickshell
  linux-wallpaperengine
  scrcpy
  pywalfox-native
  easyeffects
  libsForQt5.qt5ct
  wl-clipboard
  adwaita-qt
  adwaita-qt6
  adw-gtk3
  themechanger
  qpwgraph
  nautilus
  nautilus-open-any-terminal
  nautilus-python
  sushi
  nwg-look
  kdePackages.qt6ct
  matugen
  cava
  iio-hyprland
  iio-sensor-proxy
  jq
  tesseract
  khal
  dgop
  imhex
  onboard
  gromit-mpx
  papirus-icon-theme
  papirus-folders
  adwaita-icon-theme
  adwaita-icon-theme-legacy
  tela-icon-theme
  morewaita-icon-theme
  material-cursors
  kdePackages.breeze-gtk
  kdePackages.breeze
  feh
  themix-gui
  seahorse
  moonlight-qt
 ];
   services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    
  };
  services.gnome.gnome-keyring.enable = true;
security.pam.services.login.enableGnomeKeyring = true;
 services.tailscale.enable = true;
 services.dbus.enable = true;
 xdg.portal = {
  enable = true;
  extraPortals = [pkgs.xdg-desktop-portal-gtk];
 };
 programs.gamemode.enable = true;
 programs.dconf.enable = true;
 security.rtkit.enable = true;
 services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
 };
 services.cloudflare-warp.enable = true;


services.pipewire.extraConfig.pipewire."99-convolution-filter" = {
  "context.modules" = [
    {
      name = "libpipewire-module-filter-chain";
      args = {
        "node.description" = "Laptop Speakers (Corrected)";
        "media.name" = "Laptop Speakers (Corrected)";
        "filter.graph" = {
          nodes = [
            {
              type = "builtin";
              name = "convolver_L";
              label = "convolver";
              config = { "filename" = "${./../../../assets/Dolby-Detailed.wav}"; };
            }
            {
              type = "builtin";
              name = "convolver_R";
              label = "convolver";
              config = { "filename" = "${./../../../assets/Dolby-Detailed.wav}"; };
            }
          ];
          # This is the "glue" that makes it stereo
          inputs = [ "convolver_L:In" "convolver_R:In" ];
          outputs = [ "convolver_L:Out" "convolver_R:Out" ];
        };
        "capture.props" = {
          "node.name" = "speakers_dsp";
          "media.class" = "Audio/Sink";
          "node.description" = "Laptop Speakers (Corrected)";
          "node.nick" = "Laptop Speakers";
          "node.priority" = 2000;
          "priority.session" = 2000;
          # --- ADD THESE THREE LINES ---
          "node.virtual" = false;              # Crucial: Tells the OS "I am not a virtual stream"
          "device.class" = "sound";
          "device.api" = "alsa";
          "device.bus" = "pci";                # Pretends to be plugged into the motherboard
          "device.form-factor" = "speaker";
          "device.icon-name" = "audio-speakers";
        };
        "playback.props" = {
          "node.name" = "speakers_dsp_playback";
          "node.target" = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink";
          "audio.channels" = 2;
          "audio.position" = [ "FL" "FR" ];
          "node.passive" = true; # Links to hardware without making it public
        };
      };
    }
  ];
};

services.pipewire.wireplumber.extraConfig."10-asahi-style-internal" = {
  "monitor.alsa.rules" = [
    {
      matches = [
        { "node.name" = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink"; }
      ];
      actions = {
        update-props = {
          "node.description" = "Hidden Hardware Backend";
          "node.nick" = "Raw Speakers";
          "priority.driver" = 1; 
          "priority.session" = 1;
          "node.passive" = true;
          # This tells the Session Manager to ignore this node for the UI
          "device.pnp-id" = "ignore"; 
          "node.virtual" = true;
          "scanner.capabilities" = "none";
        };
      };
    }
  ];
};
}
