{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    git
    coreutils-prefixed
  ];
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.keep-outputs = true;
  nix.settings.keep-derivations = true;
  users.users.upendra = {
    name = "upendra";
    home = "/Users/upendra";
  };

  home-manager.users.upendra = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;
    home = {
      packages = with pkgs; [
        iterm2
        jq
        jrnl
        cairo
        poppler
        emacsPackages.pdf-tools
        emacsPackages.evil
        emacs29
        # zathura
        httpie
        grpcurl
        vscode
        xcodebuild
        slack
        redis
        teleport_12
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
      ];
      shellAliases = {
        vim = "nvim";
      };
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
      difftastic.enable = true;
    };
    programs.direnv.enable = true;
    programs.fzf.enable = true;
    programs.direnv.nix-direnv.enable = true;
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      enableAutosuggestions = true;
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
        plugins = [
          "git"
          "direnv"
          "fzf"
          "gpg-agent"
        ];
      };
    };
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ ];
    };

    
    programs.gpg.enable = true;
    # programs.gpg.publicKeys = [ { source = ./pubkeys.txt; } ];

    home.stateVersion = "23.11";
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  services.emacs = {
    enable = true;
    package = pkgs.emacs29;
  };

  # nix.package = pkgs.nix;

  homebrew = {
    enable = true;
    brews = [
      "postgresql"
      "redis"
      "consul"
    ];
    casks = [
      "firefox"
      "flycut"
      "postman"
      "jetbrains-toolbox"
      "discord"
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
