{
  inputs.vscode-server.url = "github:nix-community/nixos-vscode-server";
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; };

  outputs = { self, nixpkgs, vscode-server }:
    let
      # system = "x86_64-linux"; # check if we can remove --impure from the configuration.nix
      system = builtins.currentSystem;
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          vscode-server.nixosModules.default
          ({ config, pkgs, ... }: { services.vscode-server.enable = true; })
        ];
      };
    };
}
