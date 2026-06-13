{ pkgs, pkgs-master, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      # boost_pinned = final.boost187;

      # # 2. Apply it to Lager (fixes Krita)
      # lager = prev.lager.override {
      #   boost = final.boost_pinned;
      # };

      # # 3. Apply it to Sunshine
      # sunshine = prev.sunshine.override {
      #   boost = final.boost_pinned;
      # };
       
      #  khal = pkgs-master.khal;
      # # sunshine = pkgs-master.sunshine;
          openldap = prev.openldap.overrideAttrs (oldAttrs: {
      doCheck = false;
    });
    })

    
  ];
}