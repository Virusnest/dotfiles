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
    git
    vim
    neovim
    killall
    # System info / diagnostics
    mesa-demos        # glxinfo, glxgears
    htop
    lsof
    strace
    tmux
    btop

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
