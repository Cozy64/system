{pkgs, ...}:
{
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
