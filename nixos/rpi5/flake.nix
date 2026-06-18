{
  description = "Example Raspberry Pi 5 configuration flake";
    inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
      nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
    };

  nixConfig = {
    extra-substituters = [
      "https://nixos-raspberrypi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };

  outputs = { self, nixpkgs, nixos-raspberrypi }@inputs:
    {
      nixosConfigurations = {
        pi = nixos-raspberrypi.lib.nixosSystem {
          specialArgs = inputs;
          modules = [
            ({...}: {
              imports = with nixos-raspberrypi.nixosModules; [
                raspberry-pi-5.base
                raspberry-pi-5.bluetooth
              ];
            })
            ({ pkgs, lib, config, ... }:
            let
              normalUsers = lib.filter (u: u.isNormalUser) (lib.attrValues config.users.users);
            in {
              boot.loader.raspberry-pi.bootloader = "kernel";

  # `d` ensures the dir exists; `L+` force-recreates a symlink, where `argument` is
  systemd.tmpfiles.settings."10-home-links" = lib.mkMerge (map (u: {
    "${u.home}/.config".d = {
      mode = "0755";
      user = u.name;
      group = u.group;
    };
    "${u.home}/.config/sway"."L+".argument = "${u.home}/config/.config/sway";
  }) normalUsers);
system.stateVersion = "26.05";
time.timeZone = "Asia/Kolkata";
	      nix.gc = {
	        automatic = true;
	        randomizedDelaySec = "14m";
	        options = "--delete-older-than 30d";
	      };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";
  services.xserver.xkb.variant = "dvorak";
console = {
   useXkbConfig = true;
   earlySetup = true;
   font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
   packages = with pkgs; [ terminus_font ];
 };

services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
    openFirewall = true;
  };


  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "hdggxin";
      };
    };
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

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

nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;
  nix.settings.trusted-users = ["hdggxin"];

  nixpkgs.config.allowUnfree = true;

              environment.systemPackages = with pkgs; [
git
tree
vim
htop
tmux
networkmanager
parted
];
              networking.hostName = "pi";
              networking.networkmanager.enable = true;
              users.users.hdggxin = {
                initialPassword = "Up1997@hdggxin";
                isNormalUser = true;
                extraGroups = [
                  "wheel"
                ];
	      openssh.authorizedKeys.keys = (import ../authorized_keys.nix);
              };

              services.openssh = {
enable = true;
};
            })

            ({ ... }: {


# 
# NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
# sda           8:0    1 14.8G  0 disk 
# ├─sda1        8:1    1    1G  0 part 
# └─sda2        8:2    1 13.8G  0 part /nix/store
#                                      /
# mmcblk0     179:0    0 29.5G  0 disk 
# ├─mmcblk0p1 179:1    0  512M  0 part 
# └─mmcblk0p2 179:2    0   29G  0 part 
# 
# 
# 
# /dev/sda2: LABEL="NIXOS_SD" UUID="44444444-4444-4444-8888-888888888888" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="2175794e-02"
# /dev/sda1: LABEL_FATBOOT="FIRMWARE" LABEL="FIRMWARE" UUID="2175-794E" BLOCK_SIZE="512" TYPE="vfat" PARTUUID="2175794e-01"
# /dev/mmcblk0p1: LABEL_FATBOOT="FIRMWARE" LABEL="FIRMWARE" UUID="1B13-7D18" BLOCK_SIZE="512" TYPE="vfat" PARTLABEL="ESP" PARTUUID="1fadce79-8e18-4e1e-87eb-a43fce290579"
# /dev/mmcblk0p2: LABEL="NIXOS_SD" UUID="40593f3a-13c4-4a2e-8528-3f9dee9ccac7" BLOCK_SIZE="4096" TYPE="ext4" PARTLABEL="primary" PARTUUID="166d2b5b-eea9-4f88-a0d1-218a22944311"
# 
              fileSystems = {
                "/boot/firmware" = {
                  device = "/dev/mmcblk0p1";
                  fsType = "vfat";
                  options = [
                    "noatime"
                    "noauto"
                    "x-systemd.automount"
                    "x-systemd.idle-timeout=1min"
                  ];
                };
                "/" = {
                  device = "/dev/mmcblk0p2";
                  fsType = "ext4";
                  options = [ "noatime" ];
                };
              };
            })
          ];
        };
      };
    };
}
