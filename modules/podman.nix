{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    distrobox
		podman-compose
    freerdp
    winboat
    #docker-compose
  ];


  virtualisation = {
    podman = { 
			enable = true;
		  dockerCompat = true;
			defaultNetwork.settings.dns_enabled = true;
			dockerSocket.enable = true;
  	};
	};
}

