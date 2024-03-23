{ config, pkgs, ... }:
with pkgs;
writeShellApplication {
  name = "totp";
  runtimeInputs = with pkgs; [ cloak ];
  text = ''
    cloak view vpn | tr -d '\n' | pbcopy
  '';
}
