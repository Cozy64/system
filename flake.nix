{
  description = "Flake Systems";

  inputs = {
    # Nixpkgs channels
    stablenixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    oldnixpkgs.url = "github:NixOS/nixpkgs/27272c21afa6e506f8700f751b6bdec0dc8924c8";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Disko (for declarative partitioning / nixos-anywhere)
    disko.url = "github:nix-community/disko";

    # Example external package source
    new-bottles = {
      url = "github:bottlesdevs/Bottles/main";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, stablenixpkgs, oldnixpkgs, home-manager, disko, ... }@inputs:
  let
    system = "x86_64-linux"; # set your arch here, or use builtins.currentSystem
    stablePkgs = import stablenixpkgs { inherit system; };
    oldPkgs = import oldnixpkgs { inherit system; config.allowUnfree = true; };
  in {

    nixosConfigurations.slave = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit oldPkgs inputs; };
      modules = [
        home-manager.nixosModules.default
        inputs.lanzaboote.nixosModules.lanzaboote
        ./base.nix
        ./alias-slave.nix
        ./lanzaboote.nix
        ./home-manager.nix
        ./disk-slave.nix
        ./firmware-amd.nix
        ./modules/virtualisation.nix
        ./modules/ssh.nix
        ./modules/language.nix
        ./modules/gui.nix
        ./modules/printing.nix
        ./modules/steam.nix
        ./modules/opentabletdriver.nix
        #./modules/rgb.nix
        ./modules/asusd.nix

        ({ pkgs, ... }: {
          nixpkgs.config.packageOverrides = pkgs: {
            new-bottles = pkgs.bottles.overrideAttrs (oldAttrs: {
              src = inputs.new-bottles;
            });
          };

          environment.systemPackages = [
            oldPkgs.bitwig-studio
          ];

  
          networking.hostName = "slave";

        })
      ];
    };

    nixosConfigurations.rust = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit oldPkgs inputs; };
      modules = [
        home-manager.nixosModules.default
        ./base.nix
        ./alias-rust.nix
        ./boot.nix
        ./home-manager.nix
        ./disk-rust.nix
        ./firmware-amd.nix
        ./modules/virtualisation.nix
        ./modules/ssh.nix
        ./modules/language.nix
        ./modules/gui.nix
        ./modules/printing.nix

        ({ pkgs, ... }: {
          nixpkgs.config.packageOverrides = pkgs: {
            new-bottles = pkgs.bottles.overrideAttrs (oldAttrs: {
              src = inputs.new-bottles;
            });
          };

          environment.systemPackages = [
            oldPkgs.bitwig-studio
          ];

  
          networking.hostName = "rust";

        })
      ];
    };

    nixosConfigurations.miner = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit oldPkgs inputs; };
      modules = [
        home-manager.nixosModules.default
        ./minimal.nix
        ./boot-miner.nix
        ./firmware-intel.nix
        ./home-minimal.nix
	      ./disk-miner.nix
        ./alias-miner.nix
        ./modules/swapfile.nix
        ./modules/ssh.nix


        ({ pkgs, ... }: {
          nixpkgs.config.packageOverrides = pkgs: {
            new-bottles = pkgs.bottles.overrideAttrs (oldAttrs: {
              src = inputs.new-bottles;
            });
          };

          environment.systemPackages = [
            #oldPkgs.bitwig-studio
          ];

          networking.hostName = "miner";

        })
      ];
    };



  };
}
