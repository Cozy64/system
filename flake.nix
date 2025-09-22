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

    nixosConfigurations.rust = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit oldPkgs inputs; };
      modules = [
        home-manager.nixosModules.default
        ./base.nix
        ./virtualisation.nix
        ./boot.nix
        ./home-manager.nix
        ./disk-amd.nix
        ./firmware-amd.nix
        ./ssh.nix
        ./language.nix
        ./displaymanager.nix
        ./printing.nix

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
        ./base.nix
        ./boot.nix
        ./firmware-intel.nix
        ./home-manager.nix
        ./displaymanager.nix
        ./ssh.nix
        ./swapfile.nix
        ./pipewire.nix
	./disk-miner.nix


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

    nixosConfigurations.oldminer = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit oldPkgs inputs; };
      modules = [
        home-manager.nixosModules.default
        disko.nixosModules.disko
        ./minimal.nix
        ./old/disko-bios.nix
        ./old/grub.nix
        ./firmware-intel.nix
        ./disk-intel.nix
        ./ssh.nix
        ./swapfile.nix

        ({ pkgs, ... }: {
          nixpkgs.config.packageOverrides = pkgs: {
            new-bottles = pkgs.bottles.overrideAttrs (oldAttrs: {
              src = inputs.new-bottles;
            });
          };

          environment.systemPackages = [
            #oldPkgs.bitwig-studio
          ];

          networking.hostName = "oldminer";

        })
      ];
    };


  };
}
