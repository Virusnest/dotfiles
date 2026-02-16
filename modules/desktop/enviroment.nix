{ config, pkgs, ... }:

{
 programs.hyprland = {
  enable = true;
  xwayland.enable = true;
 };
 environment.sessionVariables = {
  NIXOS_OZONE_WL="1";
 };

 environment.systemPackages = with pkgs; [
  kitty
  rofi
  quickshell
  waybar
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
