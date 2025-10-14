{pkgs, ...}:
{
  programs = {
    hyprland = {
      enable = true;
      #withUWSM = true;
      #systemd.setPath.enable = true;
      #package = stable.hyprland;
      #portalPackage = stable.xdg-desktop-portal-hyprland;
    };
  };
}
