{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = object@{ config, lib, pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =  with pkgs;
        let
          totp = import ./totp.nix object;
          aegis = import ./aegis.nix object;
          # customClojure = pkgs.clojure.overrideAttrs (finalAttrs: previousAttrs: {
          #   version = "1.12.0.1479";
          #   src = pkgs.fetchurl {
          #     url = "https://github.com/clojure/brew-install/releases/download/${finalAttrs.version}/clojure-tools-${finalAttrs.version}.tar.gz";
          #     hash = "sha256-KlFcRXVd8e3zeP36+zgCUcdzbeLbFffb5V7XKV8NKWw=";
          #     };
          #   jdk = pkgs.jdk22;
          # });
          customEmacsPackages = pkgs.emacs.pkgs.overrideScope
            (self: super: { emacs = pkgs.emacs; });
        in [
          wezterm
          jq
          yq
          sq
          neovim
          jrnl
          cairo
          poppler
          (customEmacsPackages.withPackages (epkgs:
            with epkgs; [
              evil
              vterm
              pdf-tools
              nixpkgs-fmt
              nixos-options
              nix-mode
              go-mode
              magit
              haskell-mode
              rust-mode
            ]))
          cmake
          positron-bin
          # scroll-reverser
          # mixxx
          thonny
          # burpsuite
          gephi
          llpp
          shellcheck
          rustup
          go
          uv
          _1password-cli
          gopls
          graphviz
          httpie
          grpcurl
          grpcui
          # vscode # managed by kandji
          xcodebuild
          # slack  # managed by kandji
          redis
          # teleport # not required now, not allowed to ssh into machines
          obsidian
          k9s
          gh
          cloak
          ripgrep
          fd
          parallel
          kubectl
          tig
          tmux
          # rectangle # managed by kandji
          colima
          docker
          # gnupg
          # openssh # use the default on mac
          pyright
          totp
          nixfmt-classic
          # openfortivpn # not required
          # zoom-us # managed by kandji
          # aegis # Not required
          drawio
          colima
          ffmpeg-full
          imagemagick
          delta
          bat
          nixd
          kcat
          # protobuf_23 # Removed from nix
          confluent-platform
          htop
          # android-tools # Not required
          adrgen
          mupdf
          ghostscript
          lua-language-server
          transmission_4
          nom
          ghc
          haskell-language-server
          flameshot
          stern
          clojure
          m-cli
          zathura
          maccy
          stats
          discord
          cyberduck
          twine
        ] ++ builtins.filter lib.isDerivation (builtins.attrValues nerd-fonts);

       fonts.packages = with pkgs; builtins.filter lib.isDerivation (builtins.attrValues nerd-fonts);

       homebrew = {
        enable = true;
        brews = [
                # "postgresql"
                "wireguard-go"
                "wireguard-tools"
                # "redis"
                # "consul"
                # "mongodb-community"
              ];
        taps = [
                # "mongodb/brew"
                # "grishka/grishka"
              ];
        casks = [
          # "jetbrains-toolbox"
          "obs"
          # "whatsapp"
          # "firefox"
          # "postman"
          "wacom-tablet"
          # "openboard"
          # "stremio"
          "tomighty"
          "meetingbar"
          "gns3"
          # "microsoft-remote-desktop"
          # "the-unarchiver"
          # "trilium-notes"
          # "grishka/grishka/neardrop"
          # "deskpad"
          # "xournal-plus-plus"
          # "krita"
          # "maccy"
        ];
      };
      
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      programs.direnv.enable = true;
      # programs.fzf.enable = true;
      programs.direnv.nix-direnv.enable = true;

      # Enable alternative shell support in nix-darwin.
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      system.primaryUser = "upendra.upadhyay";

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      nixpkgs.config = {
        allowUnfree = true;
      };

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#GHXT016D6V
    darwinConfigurations."GHXT016D6V" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
