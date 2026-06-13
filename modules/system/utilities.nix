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
    upower

    # File management
    rsync
    fd
    bat               # cat replacement with syntax highlighting
    ripgrep           # search tool

    # Compression / archiving
    gzip
    bzip2    
    xz
    p7zip
    innoextract

    openssl
    
    util-linux
    wev
    usbutils
    toybox
    pciutils
    busybox
    screen
    minicom
    android-tools
    fastfetch
    pavucontrol
    yt-dlp

    
  ];
services.gvfs.enable = true;
  services.ollama = {
    enable = true;
    # Optional: preload models, see https://ollama.com/library
    loadModels = [ 
      "hf.co/mradermacher/gemma-3n-E2B-GGUF:Q4_K_M" 
    ];
  };


}
