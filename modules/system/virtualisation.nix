{ config, lib, pkgs, ... }:

let
  cfg = config.my.virtualisation;
in
{
  options.my.virtualisation = {
    enable = lib.mkEnableOption "virtualisation stack";

    user = lib.mkOption {
      type = lib.types.str;
      default = "virusnest";
      description = "User added to libvirtd group";
    };
  };

  config = lib.mkIf cfg.enable {

    virtualisation.libvirtd = {
      enable = true;

      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;

        swtpm.enable = true;  # TPM for Windows 11
      };
    };

    programs.virt-manager.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;

    services.spice-vdagentd.enable = true;

    users.users.${cfg.user}.extraGroups = [ "libvirtd" ];

    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      virtio-win
      qemu_kvm
    ];

    boot.kernelModules = [
      "kvm-intel"
      "kvm-amd"
    ];
  };
}
