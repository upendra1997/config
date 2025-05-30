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

    fileSystems."/mnt/passport" = {
      mountPoint = "/mnt/passport";
      device = "/dev/disk/by-uuid/406C6CEA6C6CDC62";
      fsType = "ntfs-3g, nofail";
      options = [ "rw" "uid=1000"];
      neededForBoot = false;
    };
    fileSystems."/mnt/c" = {
      mountPoint = "/mnt/c";
      device = "/dev/disk/by-uuid/28C47C0FC47BDE0E";
      fsType = "ntfs-3g, nofail";
      options = [ "rw" "uid=1000"];
      neededForBoot = false;
    };
    fileSystems."/mnt/d" = {
      mountPoint = "/mnt/d";
      device = "/dev/disk/by-uuid/7268F0B768F07AE5";
      fsType = "ntfs-3g, nofail";
      options = [ "rw" "uid=1000"];
      neededForBoot = false;
    };
    fileSystems."/mnt/e" = {
      mountPoint = "/mnt/e";
      device = "/dev/disk/by-uuid/7E3C54C03C5474DD";
      fsType = "ntfs-3g, nofail";
      options = [ "rw" "uid=1000"];
      neededForBoot = false;
    };
    # fileSystems."/mnt/gphotos" = {
    #   depends = [
    #     "/passport"
    #   ];
    #   device = "/mnt/passport/gphotos.img";
    #   options = [ "loop" "rw" "user" "uid=1000"];
    # };

    networking = {
      hostName = "nixos";
      domain = "hdggxin.in";
    };
    networking.networkmanager = {
      enable = true; # Easiest to use and most distros use this by default.
      # unmanaged = [ "type:wifi" ];
    };

    # Set your time zone.
    time.timeZone = "Asia/Kolkata";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    services.xserver.enable = true;
    services.xserver.autorun = false;
    services.xserver.videoDrivers = [ "modesetting" ];
    services.xserver.displayManager.startx.enable = true;
    services.gnome.gnome-keyring.enable = true;

    services.xrdp.enable = true;
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "security" = "user";
          #"use sendfile" = "yes";
          #"max protocol" = "smb2";
          # note: localhost is the ipv6 localhost ::1
          "hosts allow" = "192.168.0. 192.168.1. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };
        "c" = {
          "path" = "/mnt/c";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "valid users" = "hdggxin";
          "force user" = "hdggxin";
          "force group" = "users";
        };
        "d" = {
          "path" = "/mnt/d";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "valid users" = "hdggxin";
          "force user" = "hdggxin";
          "force group" = "users";
        };
        "e" = {
          "path" = "/mnt/e";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "valid users" = "hdggxin";
          "force user" = "hdggxin";
          "force group" = "users";
        };
        "passport" = {
          "path" = "/mnt/passport";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "valid users" = "hdggxin";
          "force user" = "hdggxin";
          "force group" = "users";
        };
        "nixos" = {
          "path" = "/";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "valid users" = "hdggxin";
          "force user" = "hdggxin";
          "force group" = "users";
        };
      };
    };

    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

    services.xrdp.openFirewall = true;

    services.blueman.enable = true;

      # Configure keymap in X11
    services.xserver.xkb.layout = "us";
    services.xserver.xkb.options = "eurosign:e,caps:escape";
    # services.xserver.xkb.variant = "dvorak";
    # console = {
    #   useXkbConfig = true;
    #   earlySetup = true;
    #   font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
    #   packages = with pkgs; [ terminus_font ];
    # };

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
    services.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.hdggxin = {
      isNormalUser = true;
      extraGroups = [
        "wheel" # Enable ‘sudo’ for the user.
        "docker"
        "transmission"
        "video"
      ];
      packages = with pkgs; [
        nodejs
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
        minicom
        rustup
        probe-rs-tools
        libunwind
        gcc-arm-embedded
        usbutils
        acl
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPweedtJiRm/qMcdmudRT7aW4xCi7vT0nmBEhv7gDWmq" # android
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCi8wz09UM/kE9MwV6jLEfoytsI8PhwIhCG0OyqL8HOqZDlTrfupHfIrG2KStxHnZGv/b0148wVcwkhNwBKF/ngfoRtlBsfWbfqud0sQf1DXOzk8a0lgyA8TI8iqfkhF9Luwf4nI+gnRA05xLjY3ve0jePeR9Iq1kAFW1G5Qn+noAWxTNeSxDZZjlc8AdUaI6JEqHwRfthgcHbwNEWECdq0EhI+UI3oNyYfyqqewO/z5PmficE6j2VbH18bSQMY5K215izWv33uymIcJWm7iPW4xxS9/gJupDwq+glHqGMuzoool8lhIuKaI/oNfTkxsp0ZZszKxdAihgVEA/QqhIvdfh3DRt5U4fIJJd72RCdqRrCduqRPK5VO+jM8YzU4tpx6mRGaH5Ht5sj/1OWNbO8E29hVKO51zs873K73rarmlnyT4GdrqYhhAjCOfjn0U83D9ISUucVOx4h2q3Mvt6zJP589UXoTiuEbEO9GMPhWow01AEbHo3/JLylGIBnf9bM= root@Aartis-iPhone" # aarti iphone
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK6mgs2umsNYmeGRI5uUsvgJBI0GOER5RsrpBFcp2CWp hdggxin@hdggxin" # papa's computer
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPPS8auuy6hEKeLuMn1h1C320gta/sFrK4plP2It97NZ" # Samsung
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKF0zwuGl4L9sYHKN9LlBMdzEgbvxjOt/B28QbsO1E/ upendra@st-upendra1" # Mac M3
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGhCrSYdjZLawaHt3e1qAVSouoiscYY1vUBONrlqEPY/ jsw@JSWCL-HYD-L0058" # Papa dell laptop
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMejS7mFUl13woV1Va9BMagnCphk+mKml42Qvwa1kuYd upend@DESKTOP-F650LTD" # Lenovo G5080
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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINrzDfg4yyOBtvfxjjSC2Swqro/pZn4Vhql4oruS6MUl pushp@pendra"
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
      file
      qemu-utils
      wireguard-go
      wireguard-tools
      wireguard-ui
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

    services.udev.extraRules = ''
    # CMSIS-DAP for microbit
    ACTION!="add|change", GOTO="microbit_rules_end"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE="0660", TAG+="uaccess"
    LABEL="microbit_rules_end"
    '';

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.optimise.automatic = true;
    nix.settings.auto-optimise-store = true;

    nixpkgs.config.allowUnfree = true;
    # nixpkgs.config.allowBroken = true;

    programs.neovim.enable = true;

    programs.neovim.defaultEditor = true;

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    programs.light.enable = true;

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
      enable = false;
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
        };
      };
    };


    # services.trilium-server = {
    #   enable = true;
    # };

    systemd.mounts = [
      {
        what = "/mnt/passport/gphotos.img";
        where = "/mnt/gphotos";
        type = "auto"; # or use actual fs type like ext4
        options = "loop,rw,user,uid=1000";
        partOf = [ "resilio.service" ];
      }
    ];

    systemd.services.resilio = {
      description = "Resilio Sync";
      wantedBy = [
        # "multi-user.target"
      ];
      requires = [ "mnt-gphotos.mount" ];
      after = [ "mnt-gphotos.mount" ];
      serviceConfig = {
        ExecStart = "/home/hdggxin/resilio/start.sh";
        Restart = "always";
        User = "hdggxin"; # Optional, if it should run as a specific user
      };
      path = [ pkgs.resilio-sync ];
    };

    # systemd.services.mount-gphotos-disk= {
    #   wantedBy = [ "resilio.service" ];
    #   requiredBy = [ "resilio.service" ];
    #   path = [ pkgs.qemu-utils pkgs.kmod pkgs.util-linux ];
    #   serviceConfig.Type = "oneshot";
    #   serviceConfig.RemainAfterExit = true;
    #   script = ''
    #     # qemu-img commit /passport/gphotos.img.qcow2
    #     # rm -rf /passport/gphotos.img.qcow2
    #     mount -o loop /passport/gphotos.img /gphotos
    #     # Mount steps for the qcow2 image
    #     # modprobe nbd max_part=8
    #     # qemu-nbd -c /dev/nbd0 /passport/gphotos.img.qcow2
    #     # mount /dev/nbd0 /home/hdggxin/gphotos
    #     # Fix Corruption
    #     # sudo fsck.vfat -a /passport/gphotos.img
    #   '';
    #   preStop = ''
    #     umount /gphotos
    #     # Unmout steps for the qcow2
    #     # umount /dev/nbd0 /home/hdggxin/gphotos
    #     # qemu-nbd -d /dev/nbd0
    #     # rmmod nbd
    #   '';
    # };

    systemd.network = {
      enable = true;
      networks = {
        "10-wired" = {
          matchConfig.Name = "enp3s0";
          networkConfig = {
            Address = "192.168.1.240/24";
            Gateway = "192.168.1.1";
          };
        };
        # "20-wireless" = {
        #   matchConfig.Name = "wlp0s29f7u7";
        #   networkConfig = {
        #     Address = "192.168.1.240/24";
        #     Gateway = "192.168.1.1";
        #   };
        # };
      };
    };

    # # Dispatcher script to disable Wi-Fi when Ethernet is up
    # environment.etc."NetworkManager/dispatcher.d/10-eth-wifi-switch".text = ''
    #   #!/bin/bash
    #   IFACE="$1"
    #   STATUS="$2"

    #   if [ "$IFACE" = "enp3s0" ]; then
    #     if [ "$STATUS" = "up" ]; then
    #       nmcli device disconnect wlp0s29f7u7
    #     elif [ "$STATUS" = "down" ]; then
    #       nmcli device connect wlp0s29f7u7
    #     fi
    #   fi
    # '';

    # environment.etc."wpa_supplicant/wlp0s29f7u7.conf".text = ''
    #   ctrl_interface=/run/wpa_supplicant
    #   network={
    #     ssid="SDU_Family"
    #     psk=e76ed59c8f97945aec6b8526cd71462162396947a740ff820c6840834e8d12d7
    #   }
    # '';

    # systemd.tmpfiles.rules = [
    #   "f /etc/NetworkManager/dispatcher.d/10-eth-wifi-switch 0755 root root -"
    # ];

    # networking.useDHCP = false;
    # networking.dhcpcd.extraConfig = ''
    #  interface enp0s25
    #   metric 100
    # '';
    # networking.useNetworkd = false;
    # networking.wireless = {
    #   enable = true;
    #   scanOnLowSignal = true;
    #   networks = {
    #     "SDU_Family" = {         # SSID with spaces and/or special characters
    #       pskRaw="e76ed59c8f97945aec6b8526cd71462162396947a740ff820c6840834e8d12d7";
    #     };
    #   };
    # };
    networking.nat = {
      enable = true;
      enableIPv6 = true;
      externalInterface = "lo";
      internalInterfaces = [ "wg0" ];
    };

    networking.wg-quick = {
      interfaces = {
        wg0 = {
          # Determines the IP address and subnet of the server's end of the tunnel interface.
          address = [ "10.100.0.1/24" ];

          # The port that WireGuard listens to. Must be accessible by the client.
          listenPort = 51820;

          # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
          # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
          postUp = ''
            ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
            ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o lo -j MASQUERADE
          '';

          # This undoes the above command
          preDown = ''
            ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
            ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o lo -j MASQUERADE
          '';

          generatePrivateKeyFile = true;
          privateKeyFile = "/etc/wireguard/private.key";

          peers = [
            # List of allowed peers.
            { # Pushpendra Lenovo Legion
              publicKey = "bB41BBvAABXWPVl7tnQ4Vc6zit2gklDVLVEbkbadx2g=";
              # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
              allowedIPs = [ "10.100.0.2/32" ];
            }
            { # Upendra Windows
              publicKey = "wZeJlxXNLSEKm9CXbTX0WutLHMEVsqzIrPcJtw/YaDY=";
              allowedIPs = [ "10.100.0.3/32" ];
            }
            { # Samsung Tablet
              publicKey = "kOjGcKa+vVlQBgHX61U0+E+rhwJy8c0US549+5sth3g=";
              allowedIPs = ["10.100.0.4/32"];
            }
            { # Pushpendra Oneplus Smartphone
              publicKey = "54fOXY9z9z83hBpdEUQT8CUki0WngRgumIavlKJPOT4=";
              allowedIPs = ["10.100.0.5/32"];
            }
            { # Pushpendra Office Mac
              publicKey = "x7lRZy7ifGmT9hwgotUrAa445ie3qj1Xdj20ReW4XVU=";
              allowedIPs = ["10.100.0.6/32"];
            }
            { # Upendra Pixel
              publicKey = "NOAdPnad0kGCMECcF8nRiT5q72Qp5FevIUjMnlb5SWA=";
              allowedIPs = ["10.100.0.7/32"];
            }
          ];
        };
      };
    };

    networking.networkmanager.dns = "systemd-resolved";
    services.resolved.enable = true;

    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [
      22
      80
      443
      9091
      1900 # jellyfin
      51820 # wireguard
      8443
      5045
    ];
    networking.firewall.allowedUDPPorts = [
      22
      80
      443
      9091 # transmisson
      7395 # jellyfin
      51820 # wireguard
      8443
      27005
      27015
      5045
    ];
    system.autoUpgrade = { # https://discourse.nixos.org/t/flake-auto-upgrade-fails-because-git-repo-not-owned-by-current-user/61893/3
      enable = true;
      allowReboot = false;
      flake = "$(readlink -f /etc/nixos)";
      # channel = "https://nixos.org/channels/nixos-25.05"; # Cannot be set together with flake
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
    networking.firewall.enable = true;
    # networking.firewall.allowPing= true;
    # networking.firewall.logRefusedPackets = true;
    # networking.firewall.logRefusedUnicastsOnly = true;

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
    system.stateVersion = "25.05"; # Did you read the comment?
}

