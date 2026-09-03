{pkgs, ...}:
{
	environment.systemPackages = with pkgs; [
  polkit_gnome
		

	];
  services.hypridle.enable = true;


  programs = {
    hyprland = {
      enable = true;
      withUWSM = false;
      #systemd.setPath.enable = true;
    #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;    
    };
  };

  services = {
  };

}
