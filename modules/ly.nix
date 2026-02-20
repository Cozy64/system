{oldPkgs, ...}:
{
  services = {
    
    displayManager = {
		 ly = {
       enable = true;
       #package = oldPkgs.ly;
     };
		};
  };
}
