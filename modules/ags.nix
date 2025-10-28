{ inputs, pkgs, ... }:
{
  # add the home manager module

  home-manager.users.cozy = {
    home = { 
      stateVersion = "25.11";
  	};

    imports = [ inputs.ags.homeManagerModules.default ];

    programs.ags = {
      enable = true;

      # symlink to ~/.config/ags
      #configDir = "${inputs.self}/ags";

      # additional packages and executables to add to gjs's runtime
      extraPackages = with pkgs; [
        inputs.astal.packages.${pkgs.system}.battery
        fzf
      ];
    };
  };
}
