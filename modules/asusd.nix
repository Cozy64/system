{pkgs, gitPkgs, ...}:
{
  services = {
    
    asusd = {
      enable = true;
			package = gitPkgs.asusctl;
		};
  };
}
