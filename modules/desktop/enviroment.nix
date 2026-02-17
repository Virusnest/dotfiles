{ config, pkgs, ... }:

{
programs.dms-shell = {
  enable = true;

  systemd = {
    enable = true;             # Systemd service for auto-start
    restartIfChanged = true;   # Auto-restart dms.service when dms-shell changes
  };
  
  # Core features
  enableSystemMonitoring = true;     # System monitoring widgets (dgop)
  enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
  enableAudioWavelength = true;      # Audio visualizer (cava)
  enableCalendarEvents = true;       # Calendar integration (khal)
};
services.displayManager.dms-greeter = {
  enable = true;
  compositor.name = "hyprland";  # Or "hyprland" or "sway"
};
 programs.hyprland = {
  enable = true;
  xwayland.enable = true;
      withUWSM = true; # recommended for most users
 };
 environment.sessionVariables = {
  NIXOS_OZONE_WL="1";
 };
 
 programs.uwsm.enable = true;

 environment.systemPackages = with pkgs; [
  kitty
  rofi
  quickshell
  pywalfox-native
  libsForQt5.qt5ct
  nautilus
  kdePackages.qt6ct
  matugen
  cava
  khal
  dgop
  papirus-icon-theme
  material-cursors
 ];
 services.dbus.enable = true;
 xdg.portal = {
  enable = true;
  extraPortals = [pkgs.xdg-desktop-portal];
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
