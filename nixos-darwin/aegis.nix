object@{ config, pkgs, ... }:
with pkgs;
writeShellApplication {
  name = "aegis";
  runtimeInputs = with pkgs; [ openfortivpn ];
  text = ''
    sudo openfortivpn -c ~/aegis.conf
  '';
}
