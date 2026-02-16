# modules/system/utilities.nix
{ config, pkgs, ... }:

{
  # Add packages to the system environment
  environment.systemPackages = with pkgs; [
    # Basic utilities
    tree
    wget
    curl
    unzip
    tar
    git
    vim
    neovim

    # System info / diagnostics
    mesa_utils        # glxinfo, glxgears
    htop
    lsof
    strace
    tmux

    # File management
    rsync
    fd
    bat               # cat replacement with syntax highlighting
    ripgrep           # search tool

    # Compression / archiving
    gzip
    bzip2
    xz
  ];
}
