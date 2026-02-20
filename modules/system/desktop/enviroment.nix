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
  quickshell
  pywalfox-native
  libsForQt5.qt5ct
  adwaita-qt
  adwaita-qt6
  adw-gtk3
  themechanger
  nautilus
  nwg-look
  kdePackages.qt6ct
  matugen
  cava
  iio-hyprland
  iio-sensor-proxy
  jq
  khal
  dgop
  onboard
  gromit-mpx
  papirus-icon-theme
  adwaita-icon-theme
  adwaita-icon-theme-legacy
  tela-icon-theme
  morewaita-icon-theme
  material-cursors
  kdePackages.breeze-gtk
  kdePackages.breeze
 ];
 services.dbus.enable = true;
 xdg.portal = {
  enable = true;
  extraPortals = [pkgs.xdg-desktop-portal-gtk];
 };
 security.rtkit.enable = true;
 services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
 };
}
