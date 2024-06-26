object@{ config, pkgs, ... }:
let username = "upendra";
in {
  imports = [ <home-manager/nix-darwin> ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ vim git coreutils-prefixed ];
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.keep-outputs = true;
  nix.settings.keep-derivations = true;
  users.users.upendra = {
    name = username;
    home = "/Users/${username}";
  };

  home-manager.users.upendra = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
    home = {
      packages = with pkgs;
        let
          totp = import ./totp.nix object;
          aegis = import ./aegis.nix object;
          customEmacsPackages = pkgs.emacs.pkgs.overrideScope
            (self: super: { emacs = pkgs.emacs29; });
        in [
          iterm2
          wezterm
          jq
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
          llpp
          shellcheck
          rustup
          go
          gopls
          graphviz
          httpie
          grpcurl
          grpcui
          vscode
          xcodebuild
          slack
          redis
          teleport_14
          obsidian
          k9s
          cloak
          ripgrep
          fd
          parallel
          kubectl
          tig
          tmux
          rectangle
          colima
          docker
          gnupg
          openssh
          nerdfonts
          totp
          nixfmt-classic
          openfortivpn
          zoom-us
          aegis
          drawio
          colima
          ffmpeg_5-full
          imagemagick
          delta
          bat
          nixd
          kcat
          protobuf_23
          confluent-platform
          htop
          android-tools
          adrgen
          mupdf
          ghostscript
          lua-language-server
          transmission
          nom
          ghc
          haskell-language-server
          flameshot
          # lorien
          # rnote
        ];
      shellAliases = { vim = "nvim"; };
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
    programs.git = {
      enable = true;
      userName = "Upendra Upadhyay";
      userEmail = "upendra.upadhyay.97@gmail.com";
      signing = {
        key = "A8653EBC1131DDCF";
        signByDefault = true;
      };
      # difftastic.enable = true;
      delta.enable = true;
    };
    programs.direnv.enable = true;
    programs.fzf.enable = true;
    programs.direnv.nix-direnv.enable = true;
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      enableVteIntegration = true;
      history.expireDuplicatesFirst = true;
      history.extended = true;
      history.size = 99999999999999999;
      initExtraFirst = ''
        export PATH="/Users/upendra/bin:$PATH"
      '';
      profileExtra = ''
        export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
      '';
      prezto.enable = true;
      antidote.enable = true;
      autocd = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" "direnv" "fzf" "gpg-agent" ];
      };
    };
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ ];
    };

    programs.gpg.enable = true;
    # programs.gpg.publicKeys = [ { source = ./pubkeys.txt; } ];

    home.stateVersion = "24.11";
    programs.home-manager.enable = true;
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # services.emacs = {
  #   enable = true;
  #   package = pkgs.emacs29;
  # };

  # nix.package = pkgs.nix;

  homebrew = {
    enable = true;
    brews = [ "postgresql" "redis" "consul" "mongodb-community" ];
    taps = [ "mongodb/brew" ];
    casks = [
      "firefox"
      "whatsapp"
      "postman"
      "jetbrains-toolbox"
      "discord"
      "wacom-tablet"
      "openboard"
      "stremio"
      "tomighty"
      "microsoft-remote-desktop"
      "maccy"
      "obs"
      "the-unarchiver"
      "stats"
      "flameshot"
      "trilium-notes"
    ];
  };

  programs.zsh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
