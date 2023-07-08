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
	jq
	jrnl
        emacs
        vscode
        jetbrains.idea-ultimate
        xcodebuild
        slack
        zoom-us
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
      userEmail = "upendra.upadhyay@gojek.com";
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
	  ];
      };
    };
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        completion-treesitter
        nvim-treesitter-context
        nvim-treesitter-endwise
        nvim-treesitter-refactor
        nvim-treesitter-textobjects
        nvim-treesitter.withAllGrammars
        vim-nix
        vim-lsp
        null-ls-nvim
      ];
    };
    home.stateVersion = "23.05";
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  programs.zsh.enable = true;
  # programs.fish.enable = true;

  services.gitlab-runner.enable = true;
  services.postgresql = {
    enable = true;
  };
  services.redis.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
