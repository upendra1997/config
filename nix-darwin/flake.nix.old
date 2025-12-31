{
  description = "Upendra's Darwin System";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }: {
    darwinConfigurations."st-upendra1" = nix-darwin.lib.darwinSystem {
      modules = [ ./darwin-configuration.nix ];
    };
  };
}
