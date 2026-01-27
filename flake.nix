{
  description = "Flake Systems";

  inputs = {
    # Nixpkgs channels
    #hyprland.url = "github:hyprwm/Hyprland";
    stablenixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/5e2a59a5b1a82f89f2c7e598302a9cacebb72a67";

    oldbitwig.url = "github:NixOS/nixpkgs/27272c21afa6e506f8700f751b6bdec0dc8924c8";

    #winboat = {
    #  url = "github:TibixDev/winboat";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};


    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal.url = "github:aylur/astal";

    ags.url = "github:aylur/ags";

    # Disko (for declarative partitioning / nixos-anywhere)
    #disko.url = "github:nix-community/disko";

    # Example external package source
    #new-bottles = {
    #  url = "github:bottlesdevs/Bottles/main";
    #  flake = false;
    #};
  };

  outputs = { nixpkgs, stablenixpkgs, oldbitwig, home-manager, lanzaboote, ... }@inputs:
    let
      system = "x86_64-linux"; # set your arch here, or use builtins.currentSystem
      stablePkgs = import stablenixpkgs { inherit system; };
      oldBitwig = import oldbitwig { inherit system; config.allowUnfree = true; };
    in 
  {


    nixosConfigurations = { 

      slave = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
          /etc/nixos/hardware-configuration.nix
          ./base.nix
          ./lanzaboote.nix
          ./home-manager.nix
          ./modules/firmware-amd.nix
          ./modules/swapfile40.nix
          ./modules/alias.nix
          ./modules/ags.nix
          ./modules/tlp-amd.nix
          ./modules/virtualisation.nix
          ./modules/ssh.nix
          ./modules/language.nix 
          ./modules/fonts.nix
          ./modules/hyprland.nix
          ./modules/steam.nix
          ./modules/opentabletdriver.nix
          ./modules/rgb.nix
          ./modules/ly.nix
          ./modules/ollama.nix
          ./modules/bluetooth.nix
          #./modules/printing.nix
          #./modules/supergfxd.nix
          #./modules/asusd.nix
          #./modules/sddm.nix
          #./modules/asusd.nix

          ({ ... }: {

            environment.systemPackages = [

            ];

            networking.hostName = "slave";

          })
        ];
      };

      rust = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit oldBitwig inputs; };
        modules = [
          home-manager.nixosModules.default
          /etc/nixos/hardware-configuration.nix
          ./base.nix
          ./boot.nix
          ./home-manager.nix
          ./modules/firmware-amd.nix
          ./modules/alias.nix
          ./modules/ssh.nix
          ./modules/language.nix
          ./modules/tlp-amd.nix
          ./modules/fonts.nix
          ./modules/hyprland.nix
          ./modules/ly.nix
          ./modules/bluetooth.nix

          ({ ... }: {

            environment.systemPackages = [
              oldBitwig.bitwig-studio
            ];
    
            networking.hostName = "rust";

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
          ./boot.nix
          ./modules/firmware-intel.nix
          ./modules/tlp-intel.nix
          ./modules/alias.nix
          ./modules/swapfile.nix
          ./modules/ssh.nix


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
          ./boot.nix
          ./modules/firmware-intel.nix
          ./modules/alias.nix
          ./modules/swapfile.nix
          ./modules/ssh.nix


          ({ ... }: {

            environment.systemPackages = [

            ];

            networking.hostName = "trash";

          })
        ];
      };

    };
  };
}
