{ config, pkgs,pkgs-master, ... }:


{
programs.dms-shell = {
  enable = true;

  systemd = {
    enable = true;             # Systemd service for auto-start
    restartIfChanged = true;   # Auto-restart dms.service when dms-shell changes
  };
  package = pkgs-master.dms-shell;
  
  # Core features
  enableSystemMonitoring = true;     # System monitoring widgets (dgop)
  enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
  enableAudioWavelength = true;      # Audio visualizer (cava)
  enableCalendarEvents = true;       # Calendar integration (khal)
};
services.displayManager.dms-greeter = {
  enable = true;
  package = pkgs-master.dms-shell;
  compositor.name = "hyprland";  # Or "hyprland" or "sway"
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
      easyeffects

  dgop
  onboard
  gromit-mpx
  papirus-icon-theme
  adwaita-icon-theme
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
