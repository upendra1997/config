{ modulesPath, pkgs, ... }: {
  imports = [ "${modulesPath}/virtualisation/amazon-image.nix" ];
  ec2.efi = true;

  environment.systemPackages = with pkgs; [
    vim
    iptables
    tmux
    wireguard-tools
    htop
  ];

  users.users.root = {
    openssh.authorizedKeys.keys = (import ../authorized_keys.nix);
  };

  security.acme = {
    acceptTerms = true;
    certs."www.hdggxin.in" = {
      email = "upendra.upadhyay.97+acme@gmail.com";
      group = "users";
      environmentFile = "${pkgs.writeText "envfile" ''
        GODADDY_API_KEY=${builtins.readFile /etc/nixos/godaddy_hdggxin_key}
        GODADDY_API_SECRET=${
          builtins.readFile /etc/nixos/godaddy_hdggxin_secret
        }
        GODADDY_PROPAGATION_TIMEOUT=1800
        GODADDY_POLLING_INTERVAL=2
      ''}";
      webroot = "/var/lib/acme/acme-challenge";
      postRun = ''
        openssl pkcs12 -export -out cert.pfx -inkey key.pem -in cert.pem -password pass:
                chown acme:users cert.pfx'';
      extraDomainNames = [ "hdggxin.in" ];
    };
  };

  services.nginx = {
    enable = true;
    group = "users";
    virtualHosts."www.hdggxin.in" = {
      forceSSL = true;
      useACMEHost = "www.hdggxin.in";
      root = "/var/www/hdggxin.in";
      serverAliases = [ "hdggxin.in" ];
      locations = {
        "= /jellyfin" = {
          extraConfig = ''
            return 302 https://$host/jellyfin/;
          '';
        };
        "/chat/websocket" = {
          proxyPass = "http://10.100.0.8:5000/websocket";
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
        "/chat" = {
          proxyPass = "http://10.100.0.8:5000/";
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Protocol $scheme;
            proxy_set_header X-Forwarded-Host $http_host;
          '';
        };
        "/jellyfin/" = {
          proxyPass = "https://10.100.0.8:8920/jellyfin/";
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
          proxyPass = "https://10.100.0.8:8920/jellyfin/";
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

  networking.nat = {
    enable = true;
    enableIPv6 = true;
    externalInterface = "ens5";
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
        # TODO remove -I INPUT 1 when the server and the wireguard becomes different.
        # postUp = ''
        #   ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
        #   ${pkgs.iptables}/bin/iptables -I INPUT 1 -i wg0 -j ACCEPT
        #   ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o lo -j MASQUERADE
        # '';

        # This undoes the above command
        # preDown = ''
        #   ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
        #   ${pkgs.iptables}/bin/iptables -D INPUT -i wg0 -j ACCEPT
        #   ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o lo -j MASQUERADE
        # '';

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
            publicKey = "DXDpPCCUGq43myUxRFXo36G5cF/0ylm0jwO4kOxtKkk=";
            allowedIPs = [ "10.100.0.3/32" ];
          }
          { # Samsung Tablet
            publicKey = "20d98LH0B5kV6qWpWk7pAvUJd9GaNq/MyMcZACbkmQA=";
            allowedIPs = [ "10.100.0.4/32" ];
          }
          { # Pushpendra Oneplus Smartphone
            publicKey = "54fOXY9z9z83hBpdEUQT8CUki0WngRgumIavlKJPOT4=";
            allowedIPs = [ "10.100.0.5/32" ];
          }
          { # Pushpendra Office Mac
            publicKey = "x7lRZy7ifGmT9hwgotUrAa445ie3qj1Xdj20ReW4XVU=";
            allowedIPs = [ "10.100.0.6/32" ];
          }
          { # Upendra Pixel
            publicKey = "NOAdPnad0kGCMECcF8nRiT5q72Qp5FevIUjMnlb5SWA=";
            allowedIPs = [ "10.100.0.7/32" ];
          }
          { # NIXOS
            publicKey = "lcABkE9M5ACGaB2WFCW4dqYnGXaRrPmgghzD8V2GLS4=";
            allowedIPs = [ "10.100.0.8/32" ];
          }
          { # Upendra Office Mac
            publicKey = "nujR85SRCMGTXU+Wpp9TYKNZHDqEHqMWLb+sz64ecTc=";
            allowedIPs = [ "10.100.0.9/32" ];
          }
        ];
      };
    };
  };

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [80 22 443 4200];
  networking.firewall.allowedUDPPorts = [51820];
}
