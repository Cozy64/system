{oldPkgs, ...}:
{
  services = {
    
		 greetd = {
       enable = true;
       useTextGreeter = true;
       #package = oldPkgs.ly;
     };
	};
}
