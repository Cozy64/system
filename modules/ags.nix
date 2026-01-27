{ inputs, pkgs, ... }:
{
  # add the home manager module

  home-manager.users.cozy = {

    imports = [ inputs.ags.homeManagerModules.default ];

    programs.ags = {
      enable = true;

      # symlink to ~/.config/ags
      #configDir = "${inputs.self}/ags";

      # additional packages and executables to add to gjs's runtime
      extraPackages = with pkgs; [
        inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.battery
        inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.auth
        inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.bluetooth
        inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.notifd
        inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.tray
        inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
        inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.network
        inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.mpris
        inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.wireplumber
        fzf
      ];
    };
  };
}
