{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # ...
  };
  outputs = { self, nixpkgs }: {
    # ...

    # Add this output, colmena will read its contents for remote deployment
    colmena = {
      meta = {
        nixpkgs = import nixpkgs { system = "aarch64-linux";
#"x86_64-linux";
        };

        # This parameter functions similarly to `specialArgs` in `nixosConfigurations.xxx`,
        # used for passing custom arguments to all submodules.
        specialArgs = { inherit nixpkgs; };
      };

      # Host name = "my-nixos"
      "ip-172-31-39-251.ap-south-1.compute.internal" = { name, nodes, ... }: {
        # Parameters related to remote deployment
        deployment.targetHost = "aws"; # Remote host's IP address
        deployment.targetUser = "root"; # Remote host's username

        # This parameter functions similarly to `modules` in `nixosConfigurations.xxx`,
        # used for importing all submodules.
        imports = [ ./configuration.nix ];
      };
    };
  };
}
