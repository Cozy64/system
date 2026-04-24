{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    distrobox
		#podman-compose
    docker-compose
  ];


  virtualisation = {
      docker = {
        enable = true;
      };
	};
}

