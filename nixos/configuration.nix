# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hdggxin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      fzf
      htop
      nodejs_18
      python3
      ripgrep
      tree-sitter
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDlOohlz7jA2n/PO47NpAOYvv80szy0tHfA2YLFhbTRzOYgYbAXtsOGkuaiWyEo+SC6ww+e+Ze5Ix6BjJJXHoTn25PwplXerCxl0XEPcXXRGgHCaUkmU6TsL0DGxBkng0AT62XxnviSYtkq6DwMbbQFu9bH0x0xRnUF+eXvIFP4KzgfBeqInw7E+9gxpLqzzfsNyhykBJ+BafHjDL6GCP/cyjgvLnKYqP7wjbk7tlKyGyyXZf6ZSZ5A/w+0nQ1dk/saZMPZDj7PLO0oHTadxeu2Ri+QUkO6NFAtzqIiRPxcas1WMP4CSNPy7wad3Wqgpc3JLNOlGCFjjkGYmOPURZ+CgDu2IWQdhJYh8FiIab+0bNQkJFHY/GhHthX7A+139f4xNsfBDfUN/g57QHPKg2Iqut77eI2hbJ2JPbv0WpbLm2WWknYh0nfGMNIe2lpZCahx6gbyF4V8eBc5WlnaqYmE1rufQ2kEI/bLj2IU/0cfXV4uoo5+uZv0opSEooOuaNU= upendraupadhyay@localhost" # mac
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPweedtJiRm/qMcdmudRT7aW4xCi7vT0nmBEhv7gDWmq" # android
    ];
  };

  users.users.slaineron = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGfqTEN89CavkHkEsEIrst/w7QrfwiRzaCKwTKfWX5y28JCsG2JITiiKn/Rt+VDwvimEJivpZmaOQtU0YxeylCPcP4Edf8+liFBqSnR6F1ty4L4XKqbG75taiWxAA1b1o3VqLymxWh/o4xNRZVPD3eqCnN9u/ppV+XTMr75/7DL2bU5EL1z6WoBMHQPFw9b0r+cU7IbzfAB8vIDaU1j3rcl1C2Wcj2XfkjV0HOiXJsPzkwerDz0HEfGRTuRx6OdQ3mpdf6KKjyVLlLZ1Sry0Elek72BIBNdciLqx6Ep/wpw6B+iRZvAkfRqKKyCy8qSWq5Vg2ouScLvuCzhozA1blpVOicJm1lAJEese/gzWNIHPrlqU0DTfyx88afg3nPg3H8oJ7LQEP/ecW2l2MSPjaKTdwVOlJdk1JbD7pmYewKySxikszNWMD7N1etSipTcW0g/GZ3k5US1J84f8oGWPKSETDWtKHgkxn0hLRehS8LebILJo8Urvtr2ecYQKo3BEk= pendra@slaineron"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCUF9Riu/uYy1bTlVgYuc3iRXG8YWPS1dHbMH0Jb9zq/9qeoT24sK0QmeInqNIR80Ge0JNC9cr9dPe/pEV+kgpUKzGkxL9+/qbcFdn426LsDCJd1gnMoXRA23s9zo0kzJIuZhATP/NZAoMFTDLvd3M1G214VBhLYX4/d+kRa97wTHv20+lOGSvyEcTLgrtIdgcJR3l8ezMraYKfmu2Rs6xdCUSGIcbtkkuddnYhoZ4sfG88wmtzylxvo/3FgULL4Kd3Z4ioC4N4WFdDb2okDE77oPXGHJEFW+5J8m/cFku6kMxbNCQ3qdMX3VJ6ujSc/bW0Dro7O8jvvqxMZ1MnCiYB9nOqSiSjsK1j4+qRovfEiUfkKUjZDd7a0lfgMgd3pUDlJ97d917PMDd1Uva876HenUoeTcF5wdw+CG3WQ8c1e0t4kCG/NrEBtFxGlsWgniU7RhWdYjSPwQv91EaVkVAIr5DbcysgPehWll6QnrucQiLEekYMG6E9C6oZocSOuLM= pushp@slaineron"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    emacs
    nnn
    tmux
    wget
    openssl
    unzip
    binutils
    docker
    coreutils-full
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    listenAddresses = [{addr = "localhost";} {addr = "0.0.0.0";}];
    settings = {
      GatewayPorts = "yes";  
      PasswordAuthentication = false;
    };
  };

  services.sshd.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  programs.neovim.enable = true;

  programs.neovim.defaultEditor = true;

  services.logind.lidSwitch = "ignore";

  virtualisation.docker.enable = true;

  virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

