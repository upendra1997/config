#/bin/sh
sudo nixos-rebuild --impure --show-trace switch --upgrade --flake "$(readlink -f /etc/nixos)#nixos"
