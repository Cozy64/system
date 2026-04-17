{
  description = "Cozy's System";

  inputs = {
    # Nixpkgs channels
    #hyprland.url = "github:hyprwm/Hyprland";
    stablepkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/master";
    gitpkgs.url = "github:NixOS/nixpkgs/master";
    oldpkgs.url = "github:NixOS/nixpkgs/e6eae2ee2110f3d31110d5c222cd395303343b08";

    oldbitwig.url = "github:NixOS/nixpkgs/27272c21afa6e506f8700f751b6bdec0dc8924c8";

   quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs = { nixpkgs, gitpkgs, stablepkgs, oldpkgs, oldbitwig, home-manager, lanzaboote, quickshell, ... }@inputs:
    let
      system = "x86_64-linux"; # set your arch here, or use builtins.currentSystem
      stablePkgs = import stablepkgs { inherit system; };
      oldPkgs = import oldpkgs { inherit system; };
      gitPkgs = import gitpkgs { inherit system; };
      oldBitwig = import oldbitwig { inherit system; config.allowUnfree = true; };
    in 
  {


    nixosConfigurations = { 

      slave = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs gitPkgs stablePkgs oldPkgs ; };
        modules = [
          home-manager.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
          /etc/nixos/hardware-configuration.nix
          ./base.nix
          ./lanzaboote.nix
          ./home-manager.nix
          ./modules/amdcpu.nix
          ./modules/amdgpu.nix
          ./modules/swapfile20.nix
          ./modules/alias.nix
          ./modules/ags.nix
          ./modules/tlp-amd.nix
          ./modules/virtualisation.nix
          ./modules/ssh.nix
          ./modules/language.nix 
          ./modules/fonts.nix
          ./modules/hyprland.nix
          ./modules/niri.nix
          ./modules/steam.nix
          ./modules/opentabletdriver.nix
          ./modules/asusd.nix
          ./modules/supergfxd.nix
          ./modules/ly.nix
          ./modules/bluetooth.nix
          ./modules/zram.nix
          #./modules/printing.nix

          ({ ... }: {

            environment.systemPackages = [

            ];

            networking.hostName = "slave";

          })
        ];
      };

      rust = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit oldBitwig gitPkgs inputs; };
        modules = [
          home-manager.nixosModules.default
          /etc/nixos/hardware-configuration.nix
          ./base.nix
          ./boot.nix
          ./home-manager.nix
          ./modules/amdcpu.nix
          ./modules/amdgpu.nix
          ./modules/alias.nix
          ./modules/ssh.nix
          ./modules/language.nix
          ./modules/tlp-amd.nix
          ./modules/steam.nix
          ./modules/fonts.nix
          ./modules/hyprland.nix
          ./modules/ly.nix
          ./modules/bluetooth.nix
          ./modules/zram.nix

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
          ./modules/intelcpu.nix
          ./modules/intelgpu.nix
          ./modules/tlp-intel.nix
          ./modules/alias.nix
          ./modules/swapfile20.nix
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
          ./boot.nix
          ./modules/intelcpu.nix
          ./modules/intelgpu.nix
          ./modules/alias.nix
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

    };
  };
}
