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
  services = {
    
    displayManager = {
		#sddm = {
		#	 enable = true;
		#	 theme="catppuccin-mocha";
			 
		#	 package = pkgs.kdePackages.sddm;
		#	 wayland.enable = true;
		#	 wayland.compositor = "kwin";
			 #enableHidpi = false;
		#};
		 ly = {
       enable = true;
     };
		};
  };
}
