{
  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Melbourne";

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  services.openssh.enable = true;
}
