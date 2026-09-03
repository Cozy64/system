{
description = "Cozy's System";

  inputs = {
    # Nixpkgs channels
    #hyprland.url = "github:hyprwm/Hyprland";
    stablepkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    unstablepkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    localpkgs.url = "path:/home/cozy/nixpkgs";
    #nixpkgs.url = "github:NixOS/nixpkgs/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    #nixpkgs.url = "path:/home/cozy/nixpkgs";
    gitpkgs.url = "github:NixOS/nixpkgs/master";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";


    # Upstream TLP source from GitHub

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "stablepkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #astal.url = "github:aylur/astal";

    #ags.url = "github:aylur/ags";

    # Disko (for declarative partitioning / nixos-anywhere)
    #disko.url = "github:nix-community/disko";

    # Example external package source
    #new-bottles = {
    #  url = "github:bottlesdevs/Bottles/main";
    #  flake = false;
    #};
  };

  outputs = { nix-flatpak, localpkgs, chaotic, nixpkgs, gitpkgs, unstablepkgs, stablepkgs, home-manager, lanzaboote , ... }@inputs:
    let
      system = "x86_64-linux"; # set your arch here, or use builtins.currentSystem
      stablePkgs = import stablepkgs { inherit system; };
      unstablePkgs = import unstablepkgs { inherit system; };
      gitPkgs = import gitpkgs { inherit system; };
      localpkgs = import gitpkgs { inherit system; };
    in 
  {

    nixosConfigurations = { 

      sky = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit unstablePkgs inputs gitPkgs stablePkgs ; };
        modules = [
          home-manager.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
          nix-flatpak.nixosModules.nix-flatpak
          chaotic.nixosModules.default 
          /etc/nixos/hardware-configuration.nix
          ./base.nix
          ./home-manager.nix
          ./modules/flatpak.nix
          ./modules/ollama.nix
          ./modules/intel/boot.nix
          ./modules/intel/cpu.nix
          ./modules/intel/gpu.nix
          ./modules/intel/.nix
          ./modules/enable/lidswitchsleep.nix
          ./modules/swapfile40.nix
          ./modules/virtualisation.nix
          ./modules/podman.nix
          ./modules/alias.nix
          ./modules/fhs.nix
          ./modules/ssh.nix
          ./modules/language.nix 
          ./modules/fonts.nix
          ./modules/hyprland.nix
          #./modules/niri.nix
          ./modules/steam.nix
          ./modules/ly.nix
          ./modules/bluetooth.nix
          #./modules/zram.nix
          #./modules/printing.nix

          ({ pkgs, ... }: {


            networking.hostName = "sky";
            environment.systemPackages = [

            ];
            system.stateVersion = "26.05"; # Did you read the comment?
            home-manager.users.cozy.home = {
              stateVersion = "26.05";
              enableNixpkgsReleaseCheck = false;
              };


          })
        ];
      };



      rust = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit gitPkgs inputs; };
        modules = [
          home-manager.nixosModules.default
          chaotic.nixosModules.default 
          /etc/nixos/hardware-configuration.nix
          ./base.nix
          ./home-manager.nix
          ./modules/amd/boot.nix
          ./modules/amd/cpu.nix
          ./modules/amd/gpu.nix
          ./modules/disable/lidonsleep.nix
          ./modules/alias.nix
          ./modules/ssh.nix
          ./modules/fhs.nix
          ./modules/language.nix
          ./modules/amd/tlp.nix
          ./modules/fonts.nix
          ./modules/hyprland.nix
          ./modules/ly.nix
          ./modules/bluetooth.nix
          ./modules/zram.nix

          ({ pkgs, ... }: {


            networking.hostName = "rust";
            environment.systemPackages = [
            ];
            system.stateVersion = "26.05"; # Did you read the comment?
            home-manager.users.cozy.home = {
              stateVersion = "26.05";
              enableNixpkgsReleaseCheck = false;
              };


          })
    
        ];
      };

      miner = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.default
          /etc/nixos/hardware-configuration.nix
          ./minimal.nix
          ./modules/intel/boot.nix
          ./modules/intel/cpu.nix
          ./modules/intel/gpu.nix
          ./modules/intel/.nix
          ./modules/disable/lidonsleep.nix
          ./modules/alias.nix
          ./modules/swapfile20.nix
          ./modules/fhs.nix
          ./modules/ssh.nix
          ./modules/zram.nix


          ({ ... }: {

            environment.systemPackages = [

            ];

            networking.hostName = "miner";

          })
        ];
      };


      trash = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.default
          /etc/nixos/hardware-configuration.nix
          #disko.nixosModules.disko
          #./partitioning/disko-efi.nix
          ./minimal.nix
          ./intel-boot.nix
          ./modules/intelcpu.nix
          ./modules/intelgpu.nix
          ./modules/alias.nix
          ./modules/fhs.nix
          ./modules/swapfile20.nix
          ./modules/ssh.nix
          ./modules/zram.nix


          ({ ... }: {

            environment.systemPackages = [

            ];

            networking.hostName = "trash";

          })
        ];
      };

      #slave = nixpkgs.lib.nixosSystem {
      #  inherit system;
      #  specialArgs = { inherit inputs gitPkgs stablePkgs oldPkgs ; };
      #  modules = [
      #    home-manager.nixosModules.default
      #    lanzaboote.nixosModules.lanzaboote
      #    /etc/nixos/hardware-configuration.nix
      #    ./base.nix
      #    ./lanzaboote.nix
      #    ./home-manager.nix
      #    ./modules/amdcpu.nix
      #    ./modules/amdgpu.nix
      #    ./modules/swapfile20.nix
      #    ./modules/alias.nix
      #    ./modules/tlp-amd.nix
      #    ./modules/docker.nix
      #    ./modules/virtualisation.nix
      #    ./modules/ssh.nix
      #    ./modules/language.nix 
      #    ./modules/fonts.nix
      #    ./modules/hyprland.nix
      #    #./modules/niri.nix
      #    ./modules/steam.nix
      #    ./modules/opentabletdriver.nix
      #    ./modules/asusd.nix
      #    ./modules/supergfxd.nix
      #    ./modules/ly.nix
      #    ./modules/bluetooth.nix
      #    ./modules/zram.nix
      #    #./modules/printing.nix
#
#          ({ ... }: {
#
#            environment.systemPackages = [
#
#            ];
#
#            networking.hostName = "slave";
#
#            system.stateVersion = "26.05"; # Did you read the comment?
#            home-manager.users.cozy.home.stateVersion = "26.05";
#
#          })
#        ];
#      };

    };
  };
}
