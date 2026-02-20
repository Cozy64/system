{...}:
{
  home-manager.users.cozy = {

    xdg = {
      enable = true;
      configFile."hypr/hyprland.conf".source = /home/cozy/system/configs/hypr/hyprland1920x108060hz.conf;
    };
  };
  programs = {
    hyprland = {
      enable = true;
      #withUWSM = true;
      #systemd.setPath.enable = true;
    #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;    
    };
  };
}
