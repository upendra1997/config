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
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/passport" =
    { device = "/dev/disk/by-uuid/406C6CEA6C6CDC62";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000"];
    };

    networking.hostName = "nixos"; # Define your hostname.
    networking.networkmanager = {
      enable = true; # Easiest to use and most distros use this by default.
      # logLevel = "DEBUG";
    };

    # Set your time zone.
    time.timeZone = "Asia/Kolkata";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    services.xserver.enable = true;
    services.xserver.autorun = false;
    services.xserver.displayManager.startx.enable = true;

    services.xrdp.enable = true;
    services.xrdp.openFirewall = true;

    services.blueman.enable = true;

      # Configure keymap in X11
    services.xserver.xkb.layout = "us";
    services.xserver.xkb.options = "eurosign:e,caps:escape";
    services.xserver.xkb.variant = "dvorak";
    console.useXkbConfig = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    # Enable touchpad support (enabled default in most desktopManager).
    services.xserver.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.hdggxin = {
      isNormalUser = true;
      extraGroups = [
        "wheel" # Enable ‘sudo’ for the user.
        "docker"
        "transmission"
      ];
      packages = with pkgs; [
        nodejs_18
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
        resilio-sync
        figlet
        ffmpeg-full
        gdb
        dig
        uv
        imagemagick
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPweedtJiRm/qMcdmudRT7aW4xCi7vT0nmBEhv7gDWmq" # android
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCi8wz09UM/kE9MwV6jLEfoytsI8PhwIhCG0OyqL8HOqZDlTrfupHfIrG2KStxHnZGv/b0148wVcwkhNwBKF/ngfoRtlBsfWbfqud0sQf1DXOzk8a0lgyA8TI8iqfkhF9Luwf4nI+gnRA05xLjY3ve0jePeR9Iq1kAFW1G5Qn+noAWxTNeSxDZZjlc8AdUaI6JEqHwRfthgcHbwNEWECdq0EhI+UI3oNyYfyqqewO/z5PmficE6j2VbH18bSQMY5K215izWv33uymIcJWm7iPW4xxS9/gJupDwq+glHqGMuzoool8lhIuKaI/oNfTkxsp0ZZszKxdAihgVEA/QqhIvdfh3DRt5U4fIJJd72RCdqRrCduqRPK5VO+jM8YzU4tpx6mRGaH5Ht5sj/1OWNbO8E29hVKO51zs873K73rarmlnyT4GdrqYhhAjCOfjn0U83D9ISUucVOx4h2q3Mvt6zJP589UXoTiuEbEO9GMPhWow01AEbHo3/JLylGIBnf9bM= root@Aartis-iPhone" # aarti iphone
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK6mgs2umsNYmeGRI5uUsvgJBI0GOER5RsrpBFcp2CWp hdggxin@hdggxin" # papa's computer
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPPS8auuy6hEKeLuMn1h1C320gta/sFrK4plP2It97NZ" # Samsung
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKF0zwuGl4L9sYHKN9LlBMdzEgbvxjOt/B28QbsO1E/ upendra@st-upendra1" # Mac M3
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGhCrSYdjZLawaHt3e1qAVSouoiscYY1vUBONrlqEPY/ jsw@JSWCL-HYD-L0058" # Papa dell laptop
      ];
    };

    users.users.slaineron = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [ ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGfqTEN89CavkHkEsEIrst/w7QrfwiRzaCKwTKfWX5y28JCsG2JITiiKn/Rt+VDwvimEJivpZmaOQtU0YxeylCPcP4Edf8+liFBqSnR6F1ty4L4XKqbG75taiWxAA1b1o3VqLymxWh/o4xNRZVPD3eqCnN9u/ppV+XTMr75/7DL2bU5EL1z6WoBMHQPFw9b0r+cU7IbzfAB8vIDaU1j3rcl1C2Wcj2XfkjV0HOiXJsPzkwerDz0HEfGRTuRx6OdQ3mpdf6KKjyVLlLZ1Sry0Elek72BIBNdciLqx6Ep/wpw6B+iRZvAkfRqKKyCy8qSWq5Vg2ouScLvuCzhozA1blpVOicJm1lAJEese/gzWNIHPrlqU0DTfyx88afg3nPg3H8oJ7LQEP/ecW2l2MSPjaKTdwVOlJdk1JbD7pmYewKySxikszNWMD7N1etSipTcW0g/GZ3k5US1J84f8oGWPKSETDWtKHgkxn0hLRehS8LebILJo8Urvtr2ecYQKo3BEk= pendra@slaineron"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCUF9Riu/uYy1bTlVgYuc3iRXG8YWPS1dHbMH0Jb9zq/9qeoT24sK0QmeInqNIR80Ge0JNC9cr9dPe/pEV+kgpUKzGkxL9+/qbcFdn426LsDCJd1gnMoXRA23s9zo0kzJIuZhATP/NZAoMFTDLvd3M1G214VBhLYX4/d+kRa97wTHv20+lOGSvyEcTLgrtIdgcJR3l8ezMraYKfmu2Rs6xdCUSGIcbtkkuddnYhoZ4sfG88wmtzylxvo/3FgULL4Kd3Z4ioC4N4WFdDb2okDE77oPXGHJEFW+5J8m/cFku6kMxbNCQ3qdMX3VJ6ujSc/bW0Dro7O8jvvqxMZ1MnCiYB9nOqSiSjsK1j4+qRovfEiUfkKUjZDd7a0lfgMgd3pUDlJ97d917PMDd1Uva876HenUoeTcF5wdw+CG3WQ8c1e0t4kCG/NrEBtFxGlsWgniU7RhWdYjSPwQv91EaVkVAIr5DbcysgPehWll6QnrucQiLEekYMG6E9C6oZocSOuLM= pushp@slaineron"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfys2fjKM09STRfEUnk7EnhhKcI0KXR08vWgZrjI5Eo pendra@pendra"
      ];
    };

    environment.systemPackages = with pkgs; [
      neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      python3Full
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
      pkg-config
      xclip
      fd
      ripgrep
      htop
      gnat
      acpi
      fzf
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.mtr.enable = true;
    programs.nix-ld.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    programs.nh.enable = true;

    programs.direnv = {
      enable = true;
      silent = false;
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
      extraConfig = ''
        PermitUserEnvironment yes
        AcceptEnv *
      '';
    };
    services.fail2ban.enable = true;

    services.sshd.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.optimise.automatic = true;
    nix.settings.auto-optimise-store = true;

    nixpkgs.config.allowUnfree = true;
    # nixpkgs.config.allowBroken = true;

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
      certs."www.hdggxin.in" = {
        email = "upendra.upadhyay.97+acme@gmail.com";
        group = "users";
        # enableDebugLogs = true;
        # server = "https://acme-staging-v02.api.letsencrypt.org/directory";
        # dnsProvider = "godaddy";
        # dnsPropagationCheck = true;
        # credentialsFile = "${pkgs.writeText "godaddy-creds" ''
        # ''}";
        environmentFile = "${pkgs.writeText "envfile" ''
          GODADDY_API_KEY=${builtins.readFile /etc/nixos/godaddy_hdggxin_key}
          GODADDY_API_SECRET=${
            builtins.readFile /etc/nixos/godaddy_hdggxin_secret
          }
          GODADDY_PROPAGATION_TIMEOUT=1800
          GODADDY_POLLING_INTERVAL=2
        ''}";
        webroot = "/var/lib/acme/acme-challenge";
        postRun = "openssl pkcs12 -export -out cert.pfx -inkey key.pem -in cert.pem -password pass:
        chown acme:users cert.pfx";
        extraDomainNames = ["hdggxin.in"];
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

    services.nginx = {
      enable = true;
      group = "users";
      virtualHosts."www.hdggxin.in" = {
        forceSSL = true;
        useACMEHost = "www.hdggxin.in";
        root = "/var/www/hdggxin.in";
        serverAliases = ["hdggxin.in"];
        locations = {
          "= /jellyfin" = {
            extraConfig = ''
              return 302 https://$host/jellyfin/;
            '';
          };
          "/jellyfin/" = {
            proxyPass = "https://127.0.0.1:8920/jellyfin/";
            extraConfig = ''
              # required when the target is also TLS server with multiple hosts
              proxy_ssl_server_name on;
              # required when the server wants to use HTTP Authentication
              proxy_pass_header Authorization;

              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header X-Forwarded-Protocol $scheme;
              proxy_set_header X-Forwarded-Host $http_host;

              # Disable buffering when the nginx proxy gets very resource heavy upon streaming
              proxy_buffering off;
              '';
          };
          "/jellyfin/socket/" = {
            proxyPass = "https://127.0.0.1:8920/jellyfin/";
            proxyWebsockets = true; # needed if you need to use WebSocket
            extraConfig = ''
              # Proxy Jellyfin Websockets traffic
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "upgrade";
              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header X-Forwarded-Protocol $scheme;
              proxy_set_header X-Forwarded-Host $http_host;
            '';
          };
          "/notes/" = {
            proxyPass = "http://127.0.0.1:8080/";
            extraConfig = ''
              proxy_http_version 1.1;
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection 'upgrade';
              proxy_set_header Host $host;
              proxy_cache_bypass $http_upgrade;
            '';
          };
        };
      };
    };


    # services.trilium-server = {
    #   enable = true;
    # };

    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [ 22 80 443 9091 ];
    networking.firewall.allowedUDPPorts = [
      9091 # transmisson
    ];
    system.autoUpgrade = { # https://discourse.nixos.org/t/flake-auto-upgrade-fails-because-git-repo-not-owned-by-current-user/61893/3
      enable = true;
      allowReboot = true;
      flake = "$(readlink -f /etc/nixos)";
      flags = [
        "--impure" # Remove this in future
        "--show-trace"
        "--update-input"
        "nixpkgs"
        "--commit-lock-file"
        "-L"
      ];
    };
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    system.copySystemConfiguration = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It's perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11"; # Did you read the comment?
}

