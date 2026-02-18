{config ,pkgs, ...}:
 {
  enviroment.systemPackages =  with pkgs[
    ciscoPacketTracer8
  ]

}