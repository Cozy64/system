{
  description = "Flake Systems";

  inputs = {
    # Nixpkgs channels
    #hyprland.url = "github:hyprwm/Hyprland";
    stablenixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/5e2a59a5b1a82f89f2c7e598302a9cacebb72a67";

    oldnixpkgs.url = "github:NixOS/nixpkgs/27272c21afa6e506f8700f751b6bdec0dc8924c8";

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
    disko.url = "github:nix-community/disko";

    # Example external package source
    #new-bottles = {
    #  url = "github:bottlesdevs/Bottles/main";
    #  flake = false;
    #};
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
        /etc/nixos/hardware-configuration.nix
        ./base.nix
        ./alias-slave.nix
        ./lanzaboote.nix
        ./home-manager.nix
        ./firmware-amd.nix
        ./modules/ags.nix
        ./modules/tlp-amd.nix
        ./modules/virtualisation.nix
        ./modules/ssh.nix
        ./modules/language.nix
        ./modules/fonts.nix
        ./modules/hyprland.nix
        ./modules/printing.nix
        ./modules/steam.nix
        ./modules/opentabletdriver.nix
        ./modules/rgb.nix
        ./modules/supergfxd.nix
        ./modules/ly.nix
        #./modules/asusd.nix
        #./modules/sddm.nix
        #./modules/asusd.nix

        ({ pkgs, ... }: {

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
        /etc/nixos/hardware-configuration.nix
        ./base.nix
        ./alias-rust.nix
        ./boot.nix
        ./home-manager.nix
        ./firmware-amd.nix
        ./modules/virtualisation.nix
        ./modules/ssh.nix
        ./modules/language.nix
        ./modules/fonts.nix
        ./modules/hyprland.nix
        ./modules/printing.nix
        ./modules/ly.nix

        ({ pkgs, ... }: {

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
        /etc/nixos/hardware-configuration.nix
        #disko.nixosModules.disko
        #./hardware-configuration.nix
        #./partitioning/disko-efi.nix
        ./minimal.nix
        ./boot-miner.nix
        ./firmware-intel.nix
        ./alias-miner.nix
        ./modules/swapfile.nix
        ./modules/ssh.nix


        ({ pkgs, ... }: {
         # nixpkgs.config.packageOverrides = pkgs: {
         #   new-bottles = pkgs.bottles.overrideAttrs (oldAttrs: {
         #     src = inputs.new-bottles;
         #   });
         # };

          environment.systemPackages = [
            #oldPkgs.bitwig-studio
          ];

          networking.hostName = "miner";

        })
      ];
    };


  };
}
