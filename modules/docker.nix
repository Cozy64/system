{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    distrobox
		#podman-compose
    docker-compose
    #winboat
  ];


  virtualisation = {
      docker = {
        enable = true;
      };
	};
}

