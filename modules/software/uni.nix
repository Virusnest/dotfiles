{ config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    cisco-packet-tracer_9
  ];
}