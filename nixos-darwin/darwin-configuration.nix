{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    git
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
    home.packages = with pkgs; [
        neovim
        vscode
        jetbrains.idea-ultimate
        xcodebuild
        slack
        zoom-us
    ];
    programs.git = {
      enable = true;
      userName = "Upendra Upadhyay";
      userEmail = "upendra.upadhyay@gojek.com";
    };
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "direnv" ];
      };
    };
    home.stateVersion = "23.05";
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
