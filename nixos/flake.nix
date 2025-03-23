{
  # inputs.vscode-server.url = "github:nix-community/nixos-vscode-server";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }: # , vscode-server }:
      let
      system = builtins.currentSystem;
      pkgs = import nixpkgs { inherit system; };
    in
    {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        # vscode-server.nixosModules.default
        # ({ config, pkgs, ... }: { services.vscode-server.enable = true; })
      ];
    };
  };
}
