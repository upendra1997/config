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
            ({ pkgs, ... }: {
              boot.loader.raspberry-pi.bootloader = "kernel";
              environment.systemPackages = with pkgs; [
git
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
              };

              services.openssh.enable = true;
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
