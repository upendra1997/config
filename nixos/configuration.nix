# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

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
    extraGroups = [
      "wheel"
      "docker"
      "jellyfin"
      "transmission"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      fzf
      fd
      htop
      nodejs_18
      python3
      ripgrep
      tree-sitter
      nil
      tiny
      stig
      nixd
      jq
      openvpn
      shellcheck
      grpcurl
      delta
      bat
      tig
      parallel
      jrnl
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDgJ/IGgVKFmpW8KMgNhV5i96+UtA30jdu5B/fKzmHFVDwkevYEZ1bJKYR/mPwmKtuMvXDqgqn4VD/ypXmi/gS1WoH/+XDlSBaos7qihp/D7lY/ZsSGk/3X3uBWBEIWnhPWiQdhnWWs2fJ3lOLS0Ge8sPdaOomDNLKpV0O0MpIW4xGAtYZhM8Xy7oCwDR147m2W9xyAOz4CODbJHlsyaAP7Ny6HkKrh2FsspXjGKH0MQeqlgpwp835GCCYun4pXlpgVSJEcrWx+PlDJytIqT/DvivgY2Scxxe+1Ekk5gmIRSywP7/Cpxk0NfClj3Kmil0FjWC+kYvOPuhE+D0kYpRMfRT1gqmuqtTCjAyNfsBX9y9dYvRbLr/JdUcVGkbvPkzvLTSQ4KTfyVyPLORCR187Wvdqj3omnB+p+IyNDC74FGodsbyZ31de2VSzBfQft2eS+4HSl3SYAtA4G1ZyZR1faU+eExDxdofQkG7el3+oZrKLBlAVcRvRaBoUV0JXz0O5HV1gbvtmR/JZq4pDqSM1lg5deKc02G8/Zk+gQ/P5AXr+4wzXcPOypur/eRNflOGo9gBg2weTZwdiraOb+O871nBiitWLI82urrQADy4c0ufnpJixDoZseeYl2zYr0bcSBoSuyCrrUqGQQu9vDG6Al2p4uLMHBcK2GBoSWwUOUSw== upendra@localhost" # mac m1
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPweedtJiRm/qMcdmudRT7aW4xCi7vT0nmBEhv7gDWmq" # android
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCi8wz09UM/kE9MwV6jLEfoytsI8PhwIhCG0OyqL8HOqZDlTrfupHfIrG2KStxHnZGv/b0148wVcwkhNwBKF/ngfoRtlBsfWbfqud0sQf1DXOzk8a0lgyA8TI8iqfkhF9Luwf4nI+gnRA05xLjY3ve0jePeR9Iq1kAFW1G5Qn+noAWxTNeSxDZZjlc8AdUaI6JEqHwRfthgcHbwNEWECdq0EhI+UI3oNyYfyqqewO/z5PmficE6j2VbH18bSQMY5K215izWv33uymIcJWm7iPW4xxS9/gJupDwq+glHqGMuzoool8lhIuKaI/oNfTkxsp0ZZszKxdAihgVEA/QqhIvdfh3DRt5U4fIJJd72RCdqRrCduqRPK5VO+jM8YzU4tpx6mRGaH5Ht5sj/1OWNbO8E29hVKO51zs873K73rarmlnyT4GdrqYhhAjCOfjn0U83D9ISUucVOx4h2q3Mvt6zJP589UXoTiuEbEO9GMPhWow01AEbHo3/JLylGIBnf9bM= root@Aartis-iPhone" # aarti iphone
    ];
  };

  users.users.slaineron = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
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
    emacs29
    nnn
    tmux
    wget
    openssl
    unzip
    binutils
    docker
    coreutils-full
    pkg-config
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.direnv = {
    enable = true;
    silent = false;
    persistDerivations = true;
    loadInNixShell = true;
    direnvrcExtra = "";
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    listenAddresses = [ { addr = "localhost"; } { addr = "0.0.0.0"; } ];
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
  security.acme = {
    acceptTerms = true;
    defaults.email = "upendra.upadhyay.97+acme@gmail.com";
    certs."www.hdggxin.in" = {
      dnsProvider = "godaddy";
      dnsPropagationCheck = false;
      # Suplying password files like this will make your credentials world-readable
      # in the Nix store. This is for demonstration purpose only, do not use this in production.
      credentialsFile = "${pkgs.writeText "godaddy-creds" ''
        GODADDY_API_KEY=${builtins.readFile /etc/nixos/godaddy_hdggxin_key}
        GODADDY_API_SECRET=${
          builtins.readFile /etc/nixos/godaddy_hdggxin_secret
        }
      ''}";
    };
  };

  services.jellyfin = {
    enable = true;
    user = "hdggxin";
    group = "users";
  };

  services.transmission = {
    enable = true;
    user = "hdggxin";
    group = "users";
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 80 443 8096 9091 ];
  networking.firewall.allowedUDPPorts = [ 9091 ];
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

