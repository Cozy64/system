{pkgs, ...}:
{
  services = {
    
    displayManager = {
		sddm = {
			 enable = true;
		#	 theme="catppuccin-mocha";
			 theme="sddm-sugar-dark";
			 
		#	 package = pkgs.kdePackages.sddm;
			 wayland.enable = true;
			 wayland.compositor = "kwin";
			 enableHidpi = false;
		};
		};
  };
}

